#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TASKS_FILE="${TASKS_FILE:-$ROOT/ansible/tasks.json}"
TASKS_MD5="${TASKS_MD5:-$ROOT/ansible/tasks.md5}"

USER="${USER:-kaineer}" \
  PLAYBOOK_DIR="$ROOT/ansible" \
  TASKS_OUT="$TASKS_FILE" \
  "$ROOT/jsonnet/build.sh"

current="$(md5sum "$TASKS_FILE" | awk '{print $1}')"
if [ -f "$TASKS_MD5" ] && [ "$current" = "$(cat "$TASKS_MD5")" ]; then
  echo "[INFO] tasks.json unchanged (md5 matches $TASKS_MD5), skipping ansible"
  rm -f "$TASKS_FILE"
  exit 0
fi

cd "$ROOT/ansible"
ansible-playbook \
  -e "tasks_file=$TASKS_FILE" \
  local.yml \
  "$@"

echo "$current" >"$TASKS_MD5"
rm -f "$TASKS_FILE"
