# This file runs once at login.

# Set up a few standard directories based on:
#   https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Add all local binaries to the system path.
export PATH="${PATH}:${HOME}/.local/bin"

# Default programs to run.
export EDITOR="vim"

# Add colors to the less and man commands.
export LESS=-R
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESS_TERMCAP_mb=$'\e[1;31mm'    # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'     # begin bold
export LESS_TERMCAP_us=$'\e[1;332m'    # begin underline
export LESS_TERMCAP_so=$'\e[1;44;33m'  # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'        # end mode
export LESS_TERMCAP_ue=$'\e[0m'        # end underline
export LESS_TERMCAP_se=$'\e[0m'        # end standout-mode

# Ensure Docker is running on WSL 2. This expects you've installed Docker and
# Docker Compose directly within your WSL distro instead of Docker Desktop, such as:
#   - https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
#   - https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
#   - https://docs.docker.com/compose/install/linux/
if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if service docker status 2>&1 | grep -q "is not running"; then
        wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
            --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi
