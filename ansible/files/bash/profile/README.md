# What is that

These are scripts sourced from .bashrc to keep shell settings modularized.

# For each script

You should start with `[[ "$1" != "-i" ]] && return` in case your profile part is for interactive shell only or `[[ "$1" == "-i" ]] && return` otherwise.

# TODO

Where did I fuck up with $HOME/bin?
