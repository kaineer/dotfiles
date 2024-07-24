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
  if ! [ -f "$SSH_DIR/id_rsa" ]; then
    mkdir -p "$SSH_DIR" && chmod 700 "$SSH_DIR" && build_ssh_keys
  fi
}

install_ansible_roles() {
  if [ -f "$DOTFILES_DIR/requirements.yml" ]; then
    echo "[DEBUG] found requirements file"
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

dconf_settings() {
  dconf write "/org/gnome/terminal/legacy/default-show-menubar" false
  dconf write "/org/gnome/terminal/legacy/always-check-default-menubar" false

  dconf write "/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font" "'FiraCode Nerd Font 15'"
  dconf write "/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/palette" "['#3B3B42425252', '#BFBF61616A6A', '#A3A3BEBE8C8C', '#EBEBCBCB8B8B', '#8181A1A1C1C1', '#B4B48E8EADAD', '#8888C0C0D0D0', '#E5E5E9E9F0F0', '#4C4C56566A6A', '#BFBF61616A6A', '#A3A3BEBE8C8C', '#EBEBCBCB8B8B', '#8181A1A1C1C1', '#B4B48E8EADAD', '#8F8FBCBCBBBB', '#ECECEFEFF4F4']"
}

main() {
  ensure_git
  ensure_ansible
  ensure_ssh_keys
  install_ansible_roles
  play_ansible_playbook
  # dconf_settings
}

main
