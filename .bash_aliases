if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"

    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
fi

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias code="code-insiders"

alias dew="docker-compose exec web"

alias dpsql="docker-compose exec postgres psql"

alias drun='docker run --rm -it -v "${PWD}":/app'

alias rmpyc="find . -name '*.pyc' -exec rm -f {} \;"

alias jek="bundle exec jekyll serve --config _config.yml,_config.dev.yml --drafts --livereload"

alias octal="stat -c '%a %n'"

alias follow="namei -om"

alias diff="diff --color -u"
