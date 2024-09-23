#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

if [ -z "${WAYLAND_DISPLAY:-}" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec sway
  ~/scripts/lock.sh
fi

# alias vim="nvim"
