#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias ll='ls -la'

export VISUAL=nvim
export EDITOR=nvim
export BROWSER=w3m
export MOZ_ENABLE_WAYLAND=1
