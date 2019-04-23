#!/bin/bash
# This file runs every time you open a new terminal window.

# Limit number of lines and entries in the history.
export HISTFILESIZE=50000
export HISTSIZE=50000

# Add a timestamp to each command.
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# Duplicate lines and lines starting with a space are not put into the history.
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Ensure $LINES and $COLUMNS always get updated.
shopt -s checkwinsize

# Enable bash completion.
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Improve output of less for binary files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load aliases if they exist.
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# Determine git branch.
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set a non-distracting prompt.
PS1='\[[01;32m\]\u@\h\[[00m\]:\[[01;34m\]\w\[[00m\] \[[01;33m\]$(parse_git_branch)\[[00m\]\$ '

# If it's an xterm compatible terminal, set the title to user@host: dir.
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable chruby.
#   Requires: https://github.com/postmodern/chruby
source /usr/local/share/chruby/chruby.sh

# Enable a better reverse search experience.
#   Requires: https://github.com/junegunn/fzf (to use fzf in general)
#   Requires: https://github.com/BurntSushi/ripgrep (for using rg below)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

# WSL (Windows Subsystem for Linux) specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    # Adjustments for WSL's file / folder permission metadata.
    if [ "$(umask)" = "0000" ]; then
      umask 0022
    fi

    # Access local X-server with VcXsrv.
    #   Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY=:0

    # Configure the Docker CLI to use the Docker for Windows daemon.
    #   Requires: https://docs.docker.com/docker-for-windows/install/
    export DOCKER_HOST=tcp://localhost:2375
fi
