#!/bin/bash

set -e

USER=kaineer
HOME="/home/$USER"

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

play_ansible_playbook() {
  cd "$DOTFILES_DIR/ansible"

  VERBOSITY=""
  [[ "$DEBUG" == "true" ]] && VERBOSITY="-vvv"

  EXTRA_VARS="$DOTFILES_DIR/ansible/vars/user.yml"
  HOST_EXTRA_VARS="$DOTFILES_DIR/ansible/bars/usre/$HOSTNAME.yml"
  if [ -f "$HOST_EXTRA_VARS" ]; then
    EXTRA_VARS="$HOST_EXTRA_VARS"
  fi

  sudo \
    LC_ALL="C.UTF-8" \
    ANSIBLE_ROLES_PATH="$ROLE_PATH:$ANSIBLE_ROLES_PATH" \
    ansible-playbook $VERBOSITY -e @$EXTRA_VARS local.yml
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
