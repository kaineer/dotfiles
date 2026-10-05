# What is that

These are scripts sourced from .bashrc to keep shell settings modularized.

# Q: How should I add new script to profile?

Find profile.yml file and "Link profile files" task inside.
Then add your script name under "with_items:" key.

# For each script

You should start with `[[ "$1" != "-i" ]] && return` in case your profile part is for interactive shell only or `[[ "$1" == "-i" ]] && return` otherwise.

