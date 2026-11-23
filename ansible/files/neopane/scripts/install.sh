#!/usr/bin/env bash
# Install neopane into NEOPANE_INSTALL_DIR (default: ~/.local/bin), with npane link.
#
# Prefer a pinned GitHub release (herdr pane support is in 0.2.x).
# If the release installer fails, fall back to cargo from the same tag
# (useful when relocating / rebuilding without release assets).
#
# Env:
#   NEOPANE_VERSION      release tag (default: v0.2.2)
#   NEOPANE_INSTALL_DIR  install prefix (default: ~/.local/bin)
#   NEOPANE_FORCE=1      reinstall even if neopane already exists
set -euo pipefail

VERSION="${NEOPANE_VERSION:-v0.2.2}"
INSTALL_DIR="${NEOPANE_INSTALL_DIR:-$HOME/.local/bin}"
BIN="$INSTALL_DIR/neopane"
REPO="spiritledsoftware/neopane"
UPSTREAM_INSTALL="https://github.com/$REPO/releases/download/$VERSION/install.sh"

say() { printf 'neopane: %s\n' "$*"; }

if [ -x "$BIN" ] && [ "${NEOPANE_FORCE:-0}" != "1" ]; then
  say "already installed at $BIN ($("$BIN" --version 2>/dev/null | head -1 || echo ok))"
  exit 0
fi

mkdir -p "$INSTALL_DIR"

try_release() {
  command -v curl >/dev/null 2>&1 || return 1
  local tmp
  tmp="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm -f '$tmp'" RETURN
  say "downloading upstream install.sh ($VERSION)"
  curl -fsSL --retry 3 -o "$tmp" "$UPSTREAM_INSTALL" || return 1
  chmod 755 "$tmp"
  NEOPANE_VERSION="$VERSION" NEOPANE_INSTALL_DIR="$INSTALL_DIR" bash "$tmp"
}

try_cargo() {
  command -v cargo >/dev/null 2>&1 || {
    say "cargo not found; cannot fall back"
    return 1
  }
  say "falling back to cargo install --git --tag $VERSION"
  cargo install --locked --force \
    --git "https://github.com/$REPO.git" \
    --tag "$VERSION" \
    neopane

  local cargo_bin="${CARGO_HOME:-$HOME/.cargo}/bin/neopane"
  [ -x "$cargo_bin" ] || return 1

  # Place into INSTALL_DIR even when it differs from cargo's bin.
  if [ "$(readlink -f "$cargo_bin")" != "$(readlink -f "$BIN" 2>/dev/null || true)" ]; then
    cp "$cargo_bin" "$INSTALL_DIR/.neopane.new"
    chmod 755 "$INSTALL_DIR/.neopane.new"
    mv -f "$INSTALL_DIR/.neopane.new" "$BIN"
  fi
  ln -sfn neopane "$INSTALL_DIR/npane"
  [ -x "$BIN" ]
}

if try_release; then
  say "installed via release $VERSION → $BIN"
  exit 0
fi

say "release install failed; trying cargo"
if try_cargo; then
  say "installed via cargo ($VERSION) → $BIN"
  exit 0
fi

say "install failed"
exit 1
