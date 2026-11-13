#!/usr/bin/env bash
# Install herdr-gitview mods + binary into HERDR_APP_HOME when missing.
# Layout slot and keys are managed by ansible (main-nord / keys.json).
set -euo pipefail

HOME_DIR="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
BIN="$HOME_DIR/mods/gitview/bin/herdr-gitview"
APP_BIN="${HERDR_APP_BIN:-$(command -v herdr-app 2>/dev/null || true)}"
HC_BIN="${HC_BIN:-$(command -v hc 2>/dev/null || true)}"
HC_BIN="${HC_BIN:-$HOME/.local/bin/hc}"

say() { printf 'gitview: %s\n' "$*"; }

# Binary has no useful --help (exits 1); presence of an executable is enough.
if [ -x "$BIN" ]; then
  say "already installed at $BIN"
  exit 0
fi

command -v git >/dev/null 2>&1 || { say "git not found"; exit 1; }
command -v cargo >/dev/null 2>&1 || { say "cargo not found (rustup); skip"; exit 0; }
[ -n "$APP_BIN" ] && [ -x "$APP_BIN" ] || APP_BIN="$HOME/.local/bin/herdr-app"
[ -x "$APP_BIN" ] || { say "herdr-app not found; skip"; exit 0; }
[ -x "$HC_BIN" ] || { say "hc not found; skip"; exit 0; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
say "cloning ChmaraX/herdr-gitview…"
git clone --depth 1 https://github.com/ChmaraX/herdr-gitview.git "$TMP/repo"

# Prefer the upstream installer when the app is running (checks + app-setup).
if HERDR_APP_HOME="$HOME_DIR" "$APP_BIN" status >/dev/null 2>&1; then
  say "Herdr is up — running upstream herdr-app/install.sh"
  HERDR_APP_HOME="$HOME_DIR" HERDR_APP_BIN="$APP_BIN" \
    "$TMP/repo/herdr-app/install.sh"
  exit 0
fi

# App not running: build and copy mods; skip herdr-app check / app-setup
# (keys + Changes→gitview already come from ansible).
say "Herdr is down — building and copying mods without app-setup"
(cd "$TMP/repo" && cargo build --release --quiet)
BIN_SRC="$TMP/repo/target/release/herdr-gitview"
[ -x "$BIN_SRC" ] || { say "build failed"; exit 1; }

mkdir -p "$HOME_DIR/mods"
STAGE="$HOME_DIR/mods/.gitview-install"
rm -rf "$STAGE" && mkdir -p "$STAGE"
for d in "$TMP/repo"/herdr-app/mods/*/; do
  [ -f "$d/mod.json" ] || continue
  m=$(basename "$d")
  cp -RL "$d" "$STAGE/$m"
done
mkdir -p "$STAGE/gitview/bin"
install -m 0755 "$BIN_SRC" "$STAGE/gitview/bin/herdr-gitview"
json_str() { printf '"%s"' "$(printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g')"; }
printf '{\n  "bin": %s,\n  "herdr_app": %s,\n  "hc": %s\n}\n' \
  "$(json_str "$HOME_DIR/mods/gitview/bin/herdr-gitview")" \
  "$(json_str "$APP_BIN")" \
  "$(json_str "$HC_BIN")" >"$STAGE/gitview/config.json"

for d in "$STAGE"/*/; do
  m=$(basename "$d")
  if [ -d "$HOME_DIR/mods/$m" ]; then
    rm -rf "$HOME_DIR/mods/$m"
  fi
  mv "$d" "$HOME_DIR/mods/$m"
done
rm -rf "$STAGE"
say "installed mods into $HOME_DIR (start Herdr and run herdr-app check if needed)"
