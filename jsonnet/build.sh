#!/usr/bin/env bash
# Compile jsonnet/tasks/main.jsonnet → ansible/tasks.json (JSON ⊂ YAML).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JSONNET_DIR="$ROOT/jsonnet"
OUT="${TASKS_OUT:-$ROOT/ansible/tasks.json}"
PLAYBOOK_DIR="${PLAYBOOK_DIR:-$ROOT/ansible}"
USER_NAME="${USER:-kaineer}"

mkdir -p "$(dirname "$OUT")"

jsonnet \
  -J "$JSONNET_DIR/lib" \
  -J "$JSONNET_DIR/config" \
  -J "$JSONNET_DIR/tasks" \
  --ext-str "USER=$USER_NAME" \
  --ext-str "PLAYBOOK_DIR=$PLAYBOOK_DIR" \
  "$JSONNET_DIR/tasks/main.jsonnet" \
  | python3 -c '
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
' > "$OUT"

echo "Built $OUT (USER=$USER_NAME PLAYBOOK_DIR=$PLAYBOOK_DIR)"
