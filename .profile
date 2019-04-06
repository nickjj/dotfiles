#!/bin/bash
# This file runs once at login.

# Add all local binary paths to the system path.
export PATH="$PATH:$HOME/.local/bin"

# Default programs to run.
export EDITOR="vim"
export READER="zathura"
export FILE="ranger"

# More accurate 256 colors with Gruvbox.
#   Requires: https://github.com/morhetz/gruvbox
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# Add colors to the less and man commands.
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# If bash is the login shell, then source ~/.bashrc if it exists.
echo "$0" | grep "bash$" >/dev/null && [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
