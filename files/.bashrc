#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias ll='ls -la'
alias np='unshare -rn nvim --clean -n -c "set nobackup noswapfile noundofile"'
alias t2m='~/code/t2m/target/debug/t2m'

export VISUAL=nvim
export EDITOR=nvim
export BROWSER=w3m
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway

source /usr/share/bash-completion/completions/git
