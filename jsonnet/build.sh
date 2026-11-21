#!/usr/bin/env bash
# Compile jsonnet → ansible/tasks-system.json, tasks-user.json, vars.json (JSON ⊂ YAML).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JSONNET_DIR="$ROOT/jsonnet"
TASKS_SYSTEM_OUT="${TASKS_SYSTEM_OUT:-$ROOT/ansible/tasks-system.json}"
TASKS_USER_OUT="${TASKS_USER_OUT:-$ROOT/ansible/tasks-user.json}"
# Backward-compatible single-file override (unused by default).
TASKS_OUT="${TASKS_OUT:-}"
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

jsonnet_run() {
  jsonnet \
    -J "$JSONNET_DIR/lib" \
    -J "$JSONNET_DIR/config" \
    -J "$JSONNET_DIR/tasks" \
    --ext-str "USER=$USER_NAME" \
    --ext-str "PLAYBOOK_DIR=$PLAYBOOK_DIR" \
    "$1"
}

split_tasks() {
  local src="$1"
  local system_dest="$2"
  local user_dest="$3"
  mkdir -p "$(dirname "$system_dest")" "$(dirname "$user_dest")"
  jsonnet_run "$src" | python3 -c '
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

data = json.load(sys.stdin)
if not isinstance(data, dict) or "system" not in data or "user" not in data:
    raise SystemExit("tasks main.jsonnet must evaluate to {system, user}")
system_path, user_path = sys.argv[1], sys.argv[2]
with open(system_path, "w", encoding="utf-8") as f:
    json.dump(prefer_name(data["system"]), f, indent=2, ensure_ascii=False)
    f.write("\n")
with open(user_path, "w", encoding="utf-8") as f:
    json.dump(prefer_name(data["user"]), f, indent=2, ensure_ascii=False)
    f.write("\n")
' "$system_dest" "$user_dest"
  echo "  $src -> $system_dest ($(python3 -c "import json;print(len(json.load(open('$system_dest'))))") tasks)"
  echo "  $src -> $user_dest ($(python3 -c "import json;print(len(json.load(open('$user_dest'))))") tasks)"
}

build_vars() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  jsonnet_run "$src" | json_dump >"$dest"
  echo "  $src -> $dest"
}

echo "Building ansible artifacts (USER=$USER_NAME PLAYBOOK_DIR=$PLAYBOOK_DIR)"
split_tasks "$JSONNET_DIR/tasks/main.jsonnet" "$TASKS_SYSTEM_OUT" "$TASKS_USER_OUT"
build_vars "$JSONNET_DIR/config/vars.jsonnet" "$VARS_OUT"
echo "Done."
