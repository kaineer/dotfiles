#!/bin/bash
#
# In case of just installed debian:
#
#  $ su # enter password, become root
#  # vi /etc/sudoers  # find root, duplicate string, replace root with your username
#  # exit # then restart shell
#  $ # then start script again

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

NEED_PACKAGES=""

# Check if git is missing
#
[[ "$(which git)" == "" ]] && NEED_PACKAGES="${NEED_PACKAGES} git"

# Check if ansible is missing
#
[ ! -x "$(command -v ansible)" ] && NEED_PACKAGES="${NEED_PACKAGES} ansible"

# Install missing packages
#
[[ "$NEED_PACKAGES" != "" ]] && sudo apt install $NEED_PACKAGES --yes

# Install ssh key
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

# After successful run
#
#  * Send ssh keys to github
#  * Send ssh keys to gitlab (need it to get password storage)
#  * Clone password storage from gitlab
#  * Change remote "origin" in dotfiles repo
#
