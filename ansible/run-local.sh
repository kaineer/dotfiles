#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TASKS_FILE="${TASKS_FILE:-$ROOT/ansible/tasks.json}"
VARS_FILE="${VARS_FILE:-$ROOT/ansible/vars.json}"
TASKS_MD5="${TASKS_MD5:-$ROOT/ansible/tasks.md5}"

echo "[INFO] building $TASKS_FILE and $VARS_FILE"
USER="${USER:-kaineer}" \
  PLAYBOOK_DIR="$ROOT/ansible" \
  TASKS_OUT="$TASKS_FILE" \
  VARS_OUT="$VARS_FILE" \
  "$ROOT/jsonnet/build.sh"

if [ ! -s "$TASKS_FILE" ] || [ ! -s "$VARS_FILE" ]; then
  echo "[ERROR] build produced empty or missing tasks/vars json" >&2
  exit 1
fi

current="$(md5sum "$TASKS_FILE" "$VARS_FILE" | md5sum | awk '{print $1}')"
if [ -f "$TASKS_MD5" ] && [ "$current" = "$(cat "$TASKS_MD5")" ]; then
  echo "[INFO] tasks/vars unchanged (md5 matches $TASKS_MD5), skipping ansible"
  rm -f "$TASKS_FILE" "$VARS_FILE"
  echo "[INFO] removed build artifacts"
  exit 0
fi

echo "[INFO] tasks/vars changed or no $TASKS_MD5 — running ansible"
echo "[INFO] tasks_file=$TASKS_FILE vars_file=$VARS_FILE"

ANSIBLE_LOG="${ANSIBLE_LOG:-$ROOT/ansible/ansible-run.log}"

cd "$ROOT/ansible"
set +e
ansible-playbook \
  -e "tasks_file=$TASKS_FILE" \
  -e "vars_file=$VARS_FILE" \
  local.yml \
  "$@" 2>&1 | tee "$ANSIBLE_LOG"
ansible_rc=${PIPESTATUS[0]}
set -e

if [ "$ansible_rc" -ne 0 ]; then
  echo "[ERROR] ansible-playbook failed with exit code $ansible_rc" >&2
  echo "[ERROR] tasks/vars json kept for inspection" >&2
  echo "[ERROR] tasks.md5 NOT updated" >&2
  echo "[ERROR] ---- failed task excerpt (from $ANSIBLE_LOG) ----" >&2
  grep -n -i -E '^(fatal:|failed:|ERROR!|TASK \[)' "$ANSIBLE_LOG" | tail -n 40 >&2 || true
  echo "[ERROR] ---- full log: $ANSIBLE_LOG ----" >&2
  exit "$ansible_rc"
fi

echo "$current" >"$TASKS_MD5"
echo "[INFO] saved $TASKS_MD5"
rm -f "$TASKS_FILE" "$VARS_FILE"
echo "[INFO] removed build artifacts"
echo "[INFO] ansible finished successfully"
