#!/usr/bin/env bash
# Compile jsonnet → ansible/tasks.json and ansible/vars.json (JSON ⊂ YAML).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JSONNET_DIR="$ROOT/jsonnet"
TASKS_OUT="${TASKS_OUT:-$ROOT/ansible/tasks.json}"
VARS_OUT="${VARS_OUT:-$ROOT/ansible/vars.json}"
PLAYBOOK_DIR="${PLAYBOOK_DIR:-$ROOT/ansible}"
USER_NAME="${USER:-kaineer}"

json_dump() {
  python3 -c '
import json, sys

def prefer_name(obj):
    if isinstance(obj, list):
        return [prefer_name(x) for x in obj]
    if isinstance(obj, dict):
        keys = list(obj.keys())
        if "name" in obj:
            keys = ["name"] + [k for k in keys if k != "name"]
        return {k: prefer_name(obj[k]) for k in keys}
    return obj

json.dump(prefer_name(json.load(sys.stdin)), sys.stdout, indent=2, ensure_ascii=False)
print()
'
}

build_one() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  jsonnet \
    -J "$JSONNET_DIR/lib" \
    -J "$JSONNET_DIR/config" \
    -J "$JSONNET_DIR/tasks" \
    --ext-str "USER=$USER_NAME" \
    --ext-str "PLAYBOOK_DIR=$PLAYBOOK_DIR" \
    "$src" \
    | json_dump >"$dest"
  echo "  $src -> $dest"
}

echo "Building ansible artifacts (USER=$USER_NAME PLAYBOOK_DIR=$PLAYBOOK_DIR)"
build_one "$JSONNET_DIR/tasks/main.jsonnet" "$TASKS_OUT"
build_one "$JSONNET_DIR/config/vars.jsonnet" "$VARS_OUT"
echo "Done."
