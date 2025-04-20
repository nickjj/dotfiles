# shellcheck shell=bash

# This file runs once at login.

# Set up a few standard directories based on:
#   https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Add all local binaries to the system path and make sure they are first.
export PATH="${HOME}/.local/bin:${HOME}/.local/bin/local:${PATH}"

# Confiure Mise (programming language run-time manager).
export PATH="${XDG_DATA_HOME}/mise/shims:${PATH}"

# Default programs to run.
export EDITOR="nvim"
export DIFFPROG="nvim -d"

# Add colors to the less and man commands.
export LESS=-R
LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESS_TERMCAP_ue
export LESS_TERMCAP_mb=$'\e[1;31mm'   # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'    # begin bold
export LESS_TERMCAP_us=$'\e[1;332m'   # begin underline
export LESS_TERMCAP_so=$'\e[1;44;33m' # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'       # end mode
export LESS_TERMCAP_ue=$'\e[0m'       # end underline
export LESS_TERMCAP_se=$'\e[0m'       # end standout-mode

# Load local settings if they exist.
# shellcheck disable=SC1091
if [ -f "${XDG_CONFIG_HOME}/zsh/.zprofile.local" ]; then . "${XDG_CONFIG_HOME}/zsh/.zprofile.local"; fi
