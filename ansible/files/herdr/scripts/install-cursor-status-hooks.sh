#!/usr/bin/env bash
# Idempotent: register cursor-status hooks in ~/.cursor/hooks.json.
set -euo pipefail

HOME_DIR="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
STATUS="$HOME_DIR/mods/cursor-status/status.mjs"

if [ ! -f "$STATUS" ]; then
  printf 'cursor-status: %s missing; skip\n' "$STATUS"
  exit 0
fi

NODE="${NODE_BIN:-$(command -v node 2>/dev/null || true)}"
NODE="${NODE:-$HOME/.local/bin/node}"
if [ ! -x "$NODE" ]; then
  printf 'cursor-status: node not found; skip hooks\n'
  exit 0
fi

"$NODE" "$STATUS" install
"$NODE" "$STATUS" doctor || true
