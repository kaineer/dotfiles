#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TASKS_FILE="${TASKS_FILE:-$ROOT/ansible/tasks.json}"

USER="${USER:-kaineer}" \
  PLAYBOOK_DIR="$ROOT/ansible" \
  TASKS_OUT="$TASKS_FILE" \
  "$ROOT/jsonnet/build.sh"

cd "$ROOT/ansible"
exec ansible-playbook \
  -e "tasks_file=$TASKS_FILE" \
  local.yml \
  "$@"
