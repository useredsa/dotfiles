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
PS1='[\u@\h \W]\$ '
if [ -n "$ALTPS1" ]; then
    PS1="$ALTPS1"
fi
# Prompt: Kakoune's connect plugin prompt + usual bash prompt
if [ -e ~/.local/share/kak/connect/prompt ]; then
    PS1="\$(~/.local/share/kak/connect/prompt)$PS1"
fi

export EDITOR=kak-desktop
export PAGER=kak-pager
export MANPAGER=kak-man-pager
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias myg++="g++ -O2 -Wall -std=c++17"
alias ks="kak-shell"
alias o="xdg-open"
alias less="$PAGER"
# Add a battery status command if upower is installed
if which upower 2>/dev/null 1>&2 ; then
    alias batstat="upower -i $(upower -e | grep BAT) | grep -E \"state|time (to\ full|to\ empty)|percentage\""
fi

