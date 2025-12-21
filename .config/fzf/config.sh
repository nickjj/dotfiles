export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none --bind shift-up:preview-page-up,shift-down:preview-page-down"
export FZF_CTRL_T_OPTS="--height=100% --preview='bat --color=always {}'"

# shellcheck disable=SC1091
. "${XDG_CONFIG_HOME}/fzf/theme.sh"
