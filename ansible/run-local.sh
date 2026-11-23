#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TASKS_SYSTEM_FILE="${TASKS_SYSTEM_FILE:-$ROOT/ansible/tasks-system.json}"
TASKS_USER_FILE="${TASKS_USER_FILE:-$ROOT/ansible/tasks-user.json}"
VARS_FILE="${VARS_FILE:-$ROOT/ansible/vars.json}"
TASKS_MD5="${TASKS_MD5:-$ROOT/ansible/tasks.md5}"

MODE=full
FORCE=""
for arg in "$@"; do
  case "$arg" in
  full | home) MODE=$arg ;;
  forced) FORCE=forced ;;
  -*)
    # Pass through remaining ansible-playbook flags after -- later
    ;;
  esac
done

# Rebuild argv without mode words for ansible-playbook passthrough.
PASS=()
for arg in "$@"; do
  case "$arg" in
  full | home | forced) ;;
  *) PASS+=("$arg") ;;
  esac
done

echo "[INFO] building $TASKS_SYSTEM_FILE, $TASKS_USER_FILE and $VARS_FILE"
USER="${USER:-kaineer}" \
  PLAYBOOK_DIR="$ROOT/ansible" \
  TASKS_SYSTEM_OUT="$TASKS_SYSTEM_FILE" \
  TASKS_USER_OUT="$TASKS_USER_FILE" \
  VARS_OUT="$VARS_FILE" \
  "$ROOT/jsonnet/build.sh"

if [ ! -s "$TASKS_SYSTEM_FILE" ] || [ ! -s "$TASKS_USER_FILE" ] || [ ! -s "$VARS_FILE" ]; then
  echo "[ERROR] build produced empty or missing tasks/vars json" >&2
  exit 1
fi

current="$(md5sum "$TASKS_SYSTEM_FILE" "$TASKS_USER_FILE" "$VARS_FILE" | md5sum | awk '{print $1}')"
if [[ "$FORCE" != "forced" ]] && [ -f "$TASKS_MD5" ] && [ "$current" = "$(cat "$TASKS_MD5")" ]; then
  echo "[INFO] tasks/vars unchanged (md5 matches $TASKS_MD5), skipping ansible"
  rm -f "$TASKS_SYSTEM_FILE" "$TASKS_USER_FILE" "$VARS_FILE"
  echo "[INFO] removed build artifacts"
  exit 0
fi

RUN_SYSTEM=true
if [[ "$MODE" == "home" ]]; then
  RUN_SYSTEM=false
fi

echo "[INFO] mode=$MODE run_system=$RUN_SYSTEM force=${FORCE:-no}"
echo "[INFO] tasks_system=$TASKS_SYSTEM_FILE tasks_user=$TASKS_USER_FILE vars=$VARS_FILE"

if [[ "$RUN_SYSTEM" == "true" ]]; then
  sudo -v
fi

ANSIBLE_LOG="${ANSIBLE_LOG:-$ROOT/ansible/ansible-run.log}"

cd "$ROOT/ansible"
set +e
LC_ALL="C.UTF-8" \
  ansible-playbook \
    -e "tasks_system_file=$TASKS_SYSTEM_FILE" \
    -e "tasks_user_file=$TASKS_USER_FILE" \
    -e "vars_file=$VARS_FILE" \
    -e "run_system=$RUN_SYSTEM" \
    local.yml \
    "${PASS[@]}" 2>&1 | tee "$ANSIBLE_LOG"
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
rm -f "$TASKS_SYSTEM_FILE" "$TASKS_USER_FILE" "$VARS_FILE"
echo "[INFO] removed build artifacts"
echo "[INFO] ansible finished successfully"
