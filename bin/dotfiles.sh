#!/bin/bash

USER=${USER:-kaineer}
HOME=/home/$USER

set -e

SSH_DIR="$HOME/.ssh"
DOTFILES_DIR="$HOME/git/config/dotfiles"
ROLE_PATH="$HOME/.ansible/roles"

ensure_git() {
  if ! [ -x "$(command -v git)" ]; then
    sudo apt install git --yes
  fi
}

ensure_ansible() {
  if ! [ -x "$(command -v ansible)" ]; then
    sudo apt install ansible --yes
  fi
}

ensure_jsonnet() {
  if ! [ -x "$(command -v jsonnet)" ]; then
    sudo apt install jsonnet --yes
  fi
}

build_ssh_keys() {
  SSH_HOSTS_DIR="$SSH_DIR/hosts"
  mkdir -p $SSH_HOSTS_DIR

  ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" \
    -C "${USER}@${HOSTNAME}"

  cat "$SSH_DIR/id_rsa.pub" >>"$SSH_DIR/authorized_keys"

  chmod 600 "$SSH_DIR/authorized_keys"
}

ensure_ssh_keys() {
  if ! [ -f "$SSH_DIR/id_rsa" ]; then
    mkdir -p "$SSH_DIR" && chmod 700 "$SSH_DIR" && build_ssh_keys
  fi
}

install_ansible_roles() {
  if [ -f "$DOTFILES_DIR/requirements.yml" ]; then
    echo "[DEBUG] found requirements file"
    cd "$DOTFILES_DIR"

    ansible-galaxy collection install ansible.posix
    ansible-galaxy install -r requirements.yml
  fi
}

TASKS_SYSTEM_FILE="${TASKS_SYSTEM_FILE:-$DOTFILES_DIR/ansible/tasks-system.json}"
TASKS_USER_FILE="${TASKS_USER_FILE:-$DOTFILES_DIR/ansible/tasks-user.json}"
VARS_FILE="${VARS_FILE:-$DOTFILES_DIR/ansible/vars.json}"
TASKS_MD5="${TASKS_MD5:-$DOTFILES_DIR/ansible/tasks.md5}"

build_ansible_tasks() {
  echo "[info ] building $TASKS_SYSTEM_FILE, $TASKS_USER_FILE and $VARS_FILE"
  USER="$USER" \
    PLAYBOOK_DIR="$DOTFILES_DIR/ansible" \
    TASKS_SYSTEM_OUT="$TASKS_SYSTEM_FILE" \
    TASKS_USER_OUT="$TASKS_USER_FILE" \
    VARS_OUT="$VARS_FILE" \
    "$DOTFILES_DIR/jsonnet/build.sh"

  if [ ! -s "$TASKS_SYSTEM_FILE" ] || [ ! -s "$TASKS_USER_FILE" ] || [ ! -s "$VARS_FILE" ]; then
    echo "[error] build produced empty or missing tasks/vars json" >&2
    exit 1
  fi
}

artifacts_md5sum() {
  md5sum "$TASKS_SYSTEM_FILE" "$TASKS_USER_FILE" "$VARS_FILE" | md5sum | awk '{print $1}'
}

tasks_unchanged() {
  if [ ! -f "$TASKS_MD5" ]; then
    return 1
  fi
  if [ "$(artifacts_md5sum)" = "$(cat "$TASKS_MD5")" ]; then
    return 0
  fi
  return 1
}

save_tasks_md5() {
  artifacts_md5sum >"$TASKS_MD5"
  echo "[info ] saved $TASKS_MD5"
}

cleanup_tasks_json() {
  rm -f "$TASKS_SYSTEM_FILE" "$TASKS_USER_FILE" "$VARS_FILE"
  echo "[info ] removed tasks/vars json artifacts"
}

# Parse: full|home [forced]  — also accept bare "forced" as full+forced.
parse_mode_args() {
  MODE=full
  FORCE=""
  for arg in "$@"; do
    case "$arg" in
    full | home) MODE=$arg ;;
    forced) FORCE=forced ;;
    "") ;;
    *)
      echo "[error] unknown mode '$arg' (expected full|home|forced)" >&2
      exit 1
      ;;
    esac
  done
}

play_ansible_playbook() {
  parse_mode_args "$@"

  build_ansible_tasks

  if [[ "$FORCE" != "forced" ]]; then
    if tasks_unchanged; then
      echo "[info ] tasks unchanged (md5 matches $TASKS_MD5), skipping ansible"
      cleanup_tasks_json
      return 0
    fi
  fi

  local run_system=true
  if [[ "$MODE" == "home" ]]; then
    run_system=false
  fi

  echo "[info ] mode=$MODE run_system=$run_system force=${FORCE:-no}"
  echo "[info ] tasks_system=$TASKS_SYSTEM_FILE tasks_user=$TASKS_USER_FILE vars=$VARS_FILE"

  cd "$DOTFILES_DIR/ansible"

  VERBOSITY=""
  [[ "$DEBUG" == "true" ]] && VERBOSITY="-vvv"

  # Optional per-host user override (merges over vars.json).
  HOST_EXTRA_VARS="$DOTFILES_DIR/ansible/vars/user/$HOSTNAME.yml"
  EXTRA_ARGS=()
  if [ -f "$HOST_EXTRA_VARS" ]; then
    EXTRA_ARGS+=(-e @"$HOST_EXTRA_VARS")
  fi

  # Cache sudo credentials so system play's become works without -K.
  if [[ "$run_system" == "true" ]]; then
    sudo -v
  fi

  ANSIBLE_LOG="${ANSIBLE_LOG:-$DOTFILES_DIR/ansible/ansible-run.log}"

  set +e
  LC_ALL="C.UTF-8" \
    ANSIBLE_ROLES_PATH="$ROLE_PATH${ANSIBLE_ROLES_PATH:+:$ANSIBLE_ROLES_PATH}" \
    SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
    ansible-playbook $VERBOSITY \
      "${EXTRA_ARGS[@]}" \
      -e "tasks_system_file=$TASKS_SYSTEM_FILE" \
      -e "tasks_user_file=$TASKS_USER_FILE" \
      -e "vars_file=$VARS_FILE" \
      -e "run_system=$run_system" \
      local.yml 2>&1 | tee "$ANSIBLE_LOG"
  ansible_rc=${PIPESTATUS[0]}
  set -e

  if [ "$ansible_rc" -ne 0 ]; then
    echo "[error] ansible-playbook failed with exit code $ansible_rc" >&2
    echo "[error] tasks/vars json kept for inspection" >&2
    echo "[error] tasks.md5 NOT updated" >&2
    echo "[error] ---- failed task excerpt (from $ANSIBLE_LOG) ----" >&2
    grep -n -i -E '^(fatal:|failed:|ERROR!|TASK \[)' "$ANSIBLE_LOG" | tail -n 40 >&2 || true
    echo "[error] ---- full log: $ANSIBLE_LOG ----" >&2
    exit "$ansible_rc"
  fi

  save_tasks_md5
  cleanup_tasks_json
  echo "[info ] ansible finished successfully"
}

restart_x_server() {
  if [[ "$RESTART_X" == "" ]]; then
    return
  fi

  DM=$(cat /etc/X11/default-display-manager)
  DN=$(basename ${DM})

  case "$(basename $DN)" in
  "lightdm")
    sudo systemctl restart lightdm
    ;;
  "GDM" | "gdm")
    sudo systemctl restart gdm
    ;;
  "KDM" | "kdm")
    sudo systemctl restart kdm
    ;;
  "MDM" | "mdm")
    sudo systemctl restart mdm
    ;;
  *)
    echo " [info ] Could not restart your display manager"
    ;;
  esac
}

main() {
  ensure_git
  ensure_jsonnet
  ensure_ansible
  ensure_ssh_keys
  install_ansible_roles
  play_ansible_playbook "$@"
  restart_x_server
}

main "$@"
