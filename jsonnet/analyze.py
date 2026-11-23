#!/usr/bin/env python3
"""Analyze jsonnet usage: reachability, lib popularity, repeated blocks."""

from __future__ import annotations

import argparse
import re
import sys
from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path

IMPORT_RE = re.compile(
    r"""(?P<comment>//)?\s*(?:local\s+\w+\s*=\s*)?import(?:str)?\s*(?P<q>['"])(?P<path>[^'"]+)(?P=q)"""
)
COMMENT_LINE_RE = re.compile(r"^\s*//")
INLINE_COMMENT_RE = re.compile(r"\s+//.*$")
WS_RE = re.compile(r"\s+")

# Default entry points matching jsonnet/build.sh (+ optional helpers).
DEFAULT_ENTRIES = (
    "tasks/main.jsonnet",
    "config/vars.jsonnet",
)

DEFAULT_JPATH = (
    "lib",
    "config",
    "tasks",
)

DEFAULT_LIB_DIRS = ("lib",)


@dataclass(frozen=True)
class ImportRef:
    path: str
    line: int
    commented: bool


def rel(root: Path, path: Path) -> str:
    try:
        return str(path.resolve().relative_to(root.resolve()))
    except ValueError:
        return str(path)


def find_jsonnet_files(root: Path) -> list[Path]:
    files: list[Path] = []
    for pattern in ("**/*.jsonnet", "**/*.libsonnet"):
        files.extend(root.glob(pattern))
    return sorted({p.resolve() for p in files if p.is_file()})


def parse_imports(text: str) -> list[ImportRef]:
    refs: list[ImportRef] = []
    for i, line in enumerate(text.splitlines(), start=1):
        for m in IMPORT_RE.finditer(line):
            refs.append(
                ImportRef(
                    path=m.group("path"),
                    line=i,
                    commented=bool(m.group("comment"))
                    or bool(COMMENT_LINE_RE.match(line[: m.start() + 1])),
                )
            )
    return refs


def resolve_import(
    importer: Path,
    import_path: str,
    root: Path,
    jpaths: list[Path],
) -> Path | None:
    """Resolve like jsonnet: relative to importer, then -J paths."""
    candidates: list[Path] = []
    if not import_path.startswith("/"):
        candidates.append(importer.parent / import_path)
    for jp in jpaths:
        candidates.append(jp / import_path)

    seen: set[Path] = set()
    for cand in candidates:
        try:
            resolved = cand.resolve()
        except OSError:
            continue
        if resolved in seen:
            continue
        seen.add(resolved)
        if resolved.is_file():
            return resolved
    return None


def build_graph(
    files: list[Path],
    root: Path,
    jpaths: list[Path],
) -> tuple[dict[Path, list[tuple[Path, ImportRef]]], list[str]]:
    """active_imports[file] = [(resolved, ref), ...] for non-commented imports."""
    by_name: dict[str, list[Path]] = defaultdict(list)
    for f in files:
        by_name[f.name].append(f)

    graph: dict[Path, list[tuple[Path, ImportRef]]] = {f: [] for f in files}
    warnings: list[str] = []

    for f in files:
        text = f.read_text(encoding="utf-8")
        for ref in parse_imports(text):
            if ref.commented:
                continue
            resolved = resolve_import(f, ref.path, root, jpaths)
            if resolved is None:
                # Fallback: unique basename under root.
                matches = by_name.get(Path(ref.path).name, [])
                if len(matches) == 1:
                    resolved = matches[0]
                else:
                    warnings.append(
                        f"{rel(root, f)}:{ref.line}: unresolved import {ref.path!r}"
                    )
                    continue
            if resolved not in graph:
                # Import outside scanned tree (ignore).
                continue
            graph[f].append((resolved, ref))

    return graph, warnings


def reachable(entries: list[Path], graph: dict[Path, list[tuple[Path, ImportRef]]]) -> set[Path]:
    seen: set[Path] = set()
    stack = [e for e in entries if e in graph]
    while stack:
        cur = stack.pop()
        if cur in seen:
            continue
        seen.add(cur)
        for nxt, _ in graph.get(cur, []):
            if nxt not in seen:
                stack.append(nxt)
    return seen


def import_counts(
    graph: dict[Path, list[tuple[Path, ImportRef]]],
) -> Counter[Path]:
    counts: Counter[Path] = Counter()
    for deps in graph.values():
        for target, _ in deps:
            counts[target] += 1
    return counts


def importers_of(
    graph: dict[Path, list[tuple[Path, ImportRef]]],
    target: Path,
) -> list[Path]:
    out: list[Path] = []
    for src, deps in graph.items():
        if any(t == target for t, _ in deps):
            out.append(src)
    return sorted(out)


def normalize_line(line: str) -> str | None:
    if COMMENT_LINE_RE.match(line):
        return None
    s = INLINE_COMMENT_RE.sub("", line).strip()
    if not s:
        return None
    # Drop pure import lines — they are structure, not duplicated logic.
    if IMPORT_RE.search(s) and s.lstrip().startswith(("local ", "import")):
        return None
    return WS_RE.sub(" ", s)


@dataclass(frozen=True)
class BlockHit:
    file: Path
    start_line: int
    end_line: int
    # Indices into the normalized-line sequence (inclusive).
    start_idx: int
    end_idx: int


_PUNCT_ONLY_RE = re.compile(r"^[\s\{\}\[\]\(\),:;]+$")


def _informative(lines: list[str]) -> bool:
    """Drop clones that are mostly braces / punctuation."""
    content = [ln for ln in lines if not _PUNCT_ONLY_RE.match(ln)]
    if len(content) < 3:
        return False
    # Require some identifier-ish tokens.
    joined = " ".join(content)
    return bool(re.search(r"[A-Za-z_]{3,}", joined))


def find_repeated_blocks(
    files: list[Path],
    root: Path,
    *,
    min_lines: int = 4,
    min_occurrences: int = 3,
    max_report: int = 20,
) -> list[tuple[int, list[str], list[BlockHit]]]:
    """
    Sliding-window clone detection on normalized non-comment lines.
    Reports maximal blocks that appear in >= min_occurrences places.
    """
    # file -> list of (lineno, normalized)
    normalized: dict[Path, list[tuple[int, str]]] = {}
    for f in files:
        rows: list[tuple[int, str]] = []
        for i, line in enumerate(f.read_text(encoding="utf-8").splitlines(), start=1):
            n = normalize_line(line)
            if n is not None:
                rows.append((i, n))
        normalized[f] = rows

    # signature -> hits
    index: dict[tuple[str, ...], list[BlockHit]] = defaultdict(list)
    max_window = 16

    open_only = {"{", "[", "("}

    for f, rows in normalized.items():
        n = len(rows)
        for w in range(min_lines, min(max_window, n) + 1):
            for i in range(0, n - w + 1):
                # Don't start on punctuation / don't end on a lone opener
                # (usually the next task/object).
                if _PUNCT_ONLY_RE.match(rows[i][1]):
                    continue
                if rows[i + w - 1][1] in open_only:
                    continue
                chunk = tuple(rows[j][1] for j in range(i, i + w))
                if not _informative(list(chunk)):
                    continue
                start = rows[i][0]
                end = rows[i + w - 1][0]
                index[chunk].append(BlockHit(f, start, end, i, i + w - 1))

    candidates: list[tuple[int, int, tuple[str, ...], list[BlockHit]]] = []
    for sig, hits in index.items():
        uniq: list[BlockHit] = []
        seen_keys: set[tuple[Path, int, int]] = set()
        for h in hits:
            key = (h.file, h.start_idx, h.end_idx)
            if key not in seen_keys:
                seen_keys.add(key)
                uniq.append(h)
        if len(uniq) < min_occurrences:
            continue
        candidates.append((len(uniq), len(sig), sig, uniq))

    # Longer first, then more occurrences — keep maximal clones.
    candidates.sort(key=lambda x: (-x[1], -x[0], x[2][0]))

    reported: list[tuple[int, list[str], list[BlockHit]]] = []
    # Per-file covered normalized-index ranges from already reported clones.
    covered_ranges: dict[Path, list[tuple[int, int]]] = defaultdict(list)

    def fully_covered(h: BlockHit) -> bool:
        for a, b in covered_ranges[h.file]:
            if a <= h.start_idx and h.end_idx <= b:
                return True
        return False

    for occ, _w, sig, hits in candidates:
        remaining = [h for h in hits if not fully_covered(h)]
        if len(remaining) < min_occurrences:
            continue
        reported.append((occ, list(sig), remaining))
        for h in remaining:
            covered_ranges[h.file].append((h.start_idx, h.end_idx))
        if len(reported) >= max_report:
            break

    # Present most-duplicated first.
    reported.sort(key=lambda x: (-x[0], -len(x[1])))
    return reported


def section(title: str) -> None:
    print()
    print("=" * 72)
    print(title)
    print("=" * 72)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parent,
        help="jsonnet root (default: directory of this script)",
    )
    ap.add_argument(
        "--entry",
        action="append",
        dest="entries",
        default=None,
        help=f"entry file relative to root (repeatable; default: {', '.join(DEFAULT_ENTRIES)})",
    )
    ap.add_argument(
        "--jpath",
        action="append",
        dest="jpaths",
        default=None,
        help="library path relative to root (repeatable; default: lib,config,tasks)",
    )
    ap.add_argument(
        "--lib-dir",
        action="append",
        dest="lib_dirs",
        default=None,
        help="dirs treated as utilities for popularity report (default: lib)",
    )
    ap.add_argument("--min-lines", type=int, default=4, help="min clone window size")
    ap.add_argument(
        "--min-occurrences",
        type=int,
        default=3,
        help="report clones appearing at least this many times",
    )
    ap.add_argument("--no-clones", action="store_true", help="skip clone detection")
    args = ap.parse_args()

    root: Path = args.root.resolve()
    if not root.is_dir():
        print(f"error: root not found: {root}", file=sys.stderr)
        return 1

    entry_rels = args.entries or list(DEFAULT_ENTRIES)
    jpath_rels = args.jpaths or list(DEFAULT_JPATH)
    lib_rels = args.lib_dirs or list(DEFAULT_LIB_DIRS)

    jpaths = [(root / p).resolve() for p in jpath_rels]
    lib_dirs = [(root / p).resolve() for p in lib_rels]

    files = find_jsonnet_files(root)
    if not files:
        print(f"no .jsonnet files under {root}", file=sys.stderr)
        return 1

    entries: list[Path] = []
    for er in entry_rels:
        ep = (root / er).resolve()
        if not ep.is_file():
            print(f"warning: entry not found: {er}", file=sys.stderr)
            continue
        entries.append(ep)

    graph, warnings = build_graph(files, root, jpaths)
    used = reachable(entries, graph)
    all_set = set(files)
    unused = sorted(all_set - used, key=lambda p: rel(root, p))
    used_sorted = sorted(used, key=lambda p: rel(root, p))
    counts = import_counts(graph)

    section("Entry points")
    for e in entries:
        mark = "ok" if e in used else "MISSING"
        print(f"  [{mark}] {rel(root, e)}")
    print(f"\nJPATH: {', '.join(jpath_rels)}")
    print(f"Scanned: {len(files)} files")

    if warnings:
        section("Unresolved imports")
        for w in warnings:
            print(f"  {w}")

    section(f"Used ({len(used_sorted)})")
    for f in used_sorted:
        n = counts.get(f, 0)
        tag = "entry" if f in entries else f"imported×{n}"
        print(f"  {rel(root, f):<48}  {tag}")

    section(f"Unused ({len(unused)})")
    if not unused:
        print("  (none)")
    else:
        for f in unused:
            # Show if something comments it out.
            commented_from: list[str] = []
            for src in files:
                text = src.read_text(encoding="utf-8")
                for ref in parse_imports(text):
                    if not ref.commented:
                        continue
                    resolved = resolve_import(src, ref.path, root, jpaths)
                    if resolved == f:
                        commented_from.append(f"{rel(root, src)}:{ref.line}")
            note = ""
            if commented_from:
                note = f"  (commented import in {', '.join(commented_from)})"
            print(f"  {rel(root, f)}{note}")

    # Utility popularity: files under lib/ (or --lib-dir), ranked by import count.
    lib_files = [
        f
        for f in files
        if any(str(f).startswith(str(d) + "/") or f.parent == d for d in lib_dirs)
    ]
    section("Utility files (least used first)")
    if not lib_files:
        print("  (no lib files)")
    else:
        ranked = sorted(
            lib_files,
            key=lambda f: (counts.get(f, 0), rel(root, f)),
        )
        for f in ranked:
            n = counts.get(f, 0)
            status = "used" if f in used else "UNUSED"
            who = importers_of(graph, f)
            print(f"  {counts.get(f, 0):3d}×  [{status}]  {rel(root, f)}")
            if who and n <= 3:
                for w in who:
                    print(f"         ← {rel(root, w)}")

    if not args.no_clones:
        section(
            f"Repeated blocks (≥{args.min_occurrences}×, ≥{args.min_lines} normalized lines)"
        )
        clones = find_repeated_blocks(
            files,
            root,
            min_lines=args.min_lines,
            min_occurrences=args.min_occurrences,
        )
        if not clones:
            print("  (none found)")
        else:
            for occ, lines, hits in clones:
                print()
                print(f"  --- {occ} occurrences, {len(lines)} lines ---")
                for h in hits:
                    print(f"  {rel(root, h.file)}:{h.start_line}-{h.end_line}")
                preview = lines[:6]
                for pl in preview:
                    print(f"      | {pl}")
                if len(lines) > len(preview):
                    print(f"      | ... ({len(lines) - len(preview)} more lines)")

    print()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
