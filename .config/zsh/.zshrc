# Load colors so we can access $fg and more.
autoload -U colors && colors

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

# Enable comments when working in an interactive shell.
setopt interactive_comments

# Prompt. Using single quotes around the PROMPT is very important, otherwise
# the git branch will always be empty. Using single quotes delays the
# evaluation of the prompt. Also PROMPT is an alias to PS1.
git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo " (${branch})"
}
setopt PROMPT_SUBST
PROMPT='%B%{$fg[green]%}%n@%{$fg[green]%}%M %{$fg[blue]%}%~%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '

# History settings.
export HISTFILE="${XDG_CACHE_HOME}/zsh/.history"
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTSIZE=50000        # History lines stored in mememory.
export SAVEHIST=50000        # History lines stored on disk.
setopt INC_APPEND_HISTORY    # Immediately append commands to history file.
setopt HIST_IGNORE_ALL_DUPS  # Never add duplicate entries.
setopt HIST_IGNORE_SPACE     # Ignore commands that start with a space.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.

# Load aliases if they exist.
[ -f "${XDG_CONFIG_HOME}/zsh/.aliases" ] && . "${XDG_CONFIG_HOME}/zsh/.aliases"
[ -f "${XDG_CONFIG_HOME}/zsh/.aliases.local" ] && . "${XDG_CONFIG_HOME}/zsh/.aliases.local"

# Use modern completion system. Other than enabling globdots for showing
# hidden files, these ares values in the default generated zsh config.
autoload -U compinit
compinit
_comp_options+=(globdots)

zstyle ':completion:*' menu select=2
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''

# dircolors is a GNU utility that's not on macOS by default. With this not
# being used on macOS it means zsh's complete menu won't have colors.
command -v dircolors > /dev/null 2>&1 && eval "$(dircolors -b)"

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Use emacs keybindings even if your $EDITOR is set to Vim.
bindkey -e

# Ensure home / end keys continue to work.
bindkey '\e[1~' beginning-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[7~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[F' end-of-line
bindkey '\e[8~' end-of-line
bindkey '\e[3~' delete-char

# Enable FZF (this replaces needing ~/.fzf.zsh in your home directory).
if [[ ! "${PATH}" == *${XDG_DATA_HOME}/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}${XDG_DATA_HOME}/fzf/bin"
fi
[[ $- == *i* ]] && . "${XDG_DATA_HOME}/fzf/shell/completion.zsh" 2> /dev/null
. "${XDG_DATA_HOME}/fzf/shell/key-bindings.zsh"

# Enable asdf to manage various programming runtime versions.
[ -f "${XDG_DATA_HOME}/asdf/asdf.sh" ] && . "${XDG_DATA_HOME}/asdf/asdf.sh"

# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then
    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"
fi

# WSL 1 specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    if [ "$(umask)" = "0000" ]; then
        umask 0022
    fi

    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY=:0
fi

# Allows your gpg passphrase prompt to spawn (useful for signing commits).
export GPG_TTY="$(tty)"

# Configure FZF.
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS="--color=dark"

# zsh-autosuggestions settings.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Load / source zsh plugins.
. "${XDG_DATA_HOME}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
. "${XDG_DATA_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"
