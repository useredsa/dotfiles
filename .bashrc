# ~/.bashrc: executed by bash(1) for non-login shells.
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# history length
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
# (The option seems to slow down the prompt in my server :/) #TODO check why
if [ "$(cat /etc/hostname)" != "Server000" ]; then
    shopt -s checkwinsize
fi

# Prompt: My support for starting terminals with different prompts.
PS1='$([ "\u" = useredsa ] && [[ "\h" =~ ^Device...$ ]] ||  printf "%s" "\u@\h ")\W \$ '
if [ -n "$ALTPS1" ]; then
    PS1="$ALTPS1"
fi
# Prompt: Kakoune's connect plugin prompt + usual bash prompt
PS1="\$([ \"\$IN_KAKOUNE_CONNECT\" ] && printf '(%s)🐈' \"\$KAKOUNE_SESSION\")$PS1"

export EDITOR=kak-desktop
export PAGER=kak
export MANPAGER=kak-man-pager
export kak_session=default
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export TTY="$(tty)"

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mkdir='mkdir -pv'

alias myg++="g++ -O2 -Wall -std=c++17"
alias mylatex="pdflatex --output-dir out"
alias ks="kak-shell"
alias o="xdg-open"
alias open="xdg-open 2>/dev/null"
alias tree="br -c :pt"
# Add a battery status command if upower is installed
if which upower 2>/dev/null 1>&2 ; then
    alias batstat="upower -i $(upower -e | grep BAT) | grep -E \"state|time (to\ full|to\ empty)|percentage\""
fi

n() {
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_PLUG='p:preview-tui;n:nuke;u:imgview'
    export NNN_TRASH=1
    export TERMINAL=$TERM
    nnn -a "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

c() {
    # Automatic cd on exit
    br --only-folders --cmd "$1;:cd"
}


[[ -f ~/.config/broot/launcher/bash/br ]] && source ~/.config/broot/launcher/bash/br
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash

