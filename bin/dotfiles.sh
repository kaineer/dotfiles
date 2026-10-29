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

build_ssh_keys() {
  SSH_HOSTS_DIR="$SSH_DIR/hosts"
  mkdir -p $SSH_HOSTS_DIR

  ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" \
    -C "$USER@$HOSTNAME"

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

TASKS_FILE="${TASKS_FILE:-$DOTFILES_DIR/ansible/tasks.json}"
TASKS_MD5="${TASKS_MD5:-$DOTFILES_DIR/ansible/tasks.md5}"

build_ansible_tasks() {
  USER="$USER" \
    PLAYBOOK_DIR="$DOTFILES_DIR/ansible" \
    TASKS_OUT="$TASKS_FILE" \
    "$DOTFILES_DIR/jsonnet/build.sh"
}

tasks_md5sum() {
  md5sum "$TASKS_FILE" | awk '{print $1}'
}

tasks_unchanged() {
  [ -f "$TASKS_MD5" ] || return 1
  [ "$(tasks_md5sum)" = "$(cat "$TASKS_MD5")" ]
}

save_tasks_md5() {
  tasks_md5sum >"$TASKS_MD5"
}

cleanup_tasks_json() {
  rm -f "$TASKS_FILE"
}

play_ansible_playbook() {
  build_ansible_tasks

  if tasks_unchanged; then
    echo "[INFO] tasks.json unchanged (md5 matches $TASKS_MD5), skipping ansible"
    cleanup_tasks_json
    return 0
  fi

  cd "$DOTFILES_DIR/ansible"

  VERBOSITY=""
  [[ "$DEBUG" == "true" ]] && VERBOSITY="-vvv"

  EXTRA_VARS="$DOTFILES_DIR/ansible/vars/user.yml"
  HOST_EXTRA_VARS="$DOTFILES_DIR/ansible/vars/user/$HOSTNAME.yml"
  if [ -f "$HOST_EXTRA_VARS" ]; then
    EXTRA_VARS="$HOST_EXTRA_VARS"
  fi

  sudo \
    LC_ALL="C.UTF-8" \
    ANSIBLE_ROLES_PATH="$ROLE_PATH:$ANSIBLE_ROLES_PATH" \
    SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
    ansible-playbook $VERBOSITY \
      -e @$EXTRA_VARS \
      -e "tasks_file=$TASKS_FILE" \
      local.yml

  save_tasks_md5
  cleanup_tasks_json
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
    echo " [INFO ] Could not restart your display manager"
    ;;
  esac
}

main() {
  ensure_git
  ensure_ansible
  ensure_ssh_keys
  install_ansible_roles
  play_ansible_playbook
  restart_x_server
}

main
