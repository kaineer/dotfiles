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
  ssh-keygen -b 4096 -t rsa -t "$SSH_DIR/id_rsa" -N "" \
    -C "$USER@$HOSTNAME"

  cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

  chmod 600 "$SSH_DIR/authorized_keys"
}

ensure_ssh_keys() {
  if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
    mkdir -p "$SSH_DIR" && chmod 700 "$SSH_DIR" && build_ssh_keys
  fi
}

install_ansible_roles() {
  if [[ -f "DOTFILES_DIR/requirements.yml" ]]; then
    cd "$DOTFILES_DIR"

    ansible-galaxy install -r requirements.yml
  fi
}

play_ansible_playbook() {
  cd "$DOTFILES_DIR/ansible"

  sudo \
    LC_ALL="C.UTF-8" \
    ANSIBLE_ROLES_PATH="$ROLE_PATH:$ANSIBLE_ROLES_PATH" \
    ansible-playbook local.yml
}

main() {
  ensure_git
  ensure_ansible
  ensure_ssh_keys
  install_ansible_roles
  play_ansible_playbook
}

main
