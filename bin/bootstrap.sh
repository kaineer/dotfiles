#!/bin/bash
set -e

SSH_DIR="$HOME/.ssh"
DOTFILES_DIR="$HOME/git/config/dotfiles"

# Enable ansible-pull start
#
if [[ "$LC_ALL" == "" ]]; then
  sudo touch /etc/environment
  sudo sh -c 'echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/environment'
  sudo sh -c 'echo "LANG=\"en_US.UTF-8\"" >> /etc/environment'
fi

# Install git
#
[[ "$(which git)" == "" ]] && sudo apt install git --yes

# Install ansible
#
#
[ ! -x "$(command -v ansible)" ] && sudo apt install ansible --yes

# Install ssh key
#
#
if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
  [ ! -d "$SSH_DIR" ] && mkdir -p "$SSH_DIR"

  chmod 700 "$SSH_DIR"

  # -t - keytype
  # -f - identity file
  #
  ssh-keygen -b 4096 \
     -t rsa \
     -f "$SSH_DIR/id_rsa" \
     -N "" -C "$USER@$HOSTNAME"

  # so we can run ansible on localhost
  #
  cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

  chmod 600 "$SSH_DIR/authorized_keys"
fi

[ ! -d $DOTFILES_DIR ] && git clone \
  https://github.com/kaineer/dotfiles "$DOTFILES_DIR"

if [[ -f "$DOTFILES_DIR/requirements.yml" ]]; then
  cd "$DOTFILES_DIR"

  ansible-galaxy install -r requirements.yml
fi

if [[ -f "$DOTFILES_DIR/bin/dotfiles.sh" ]]; then
  cd "$DOTFILES_DIR"
  . ./bin/dotfiles.sh
fi
