# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="vim"
export PS1="\[\e[33m\][ \u ]\[\e[m\] \[\e[36m\]\W\[\e[m\] .// "

# bash option
shopt -s autocd dirspell cdspell

# history substring search w/ ctrl fallback
bind '"\e[A":history-search-backward'
bind '"\e[1;5D":backward-word'
bind '"\e[B":history-search-forward'
bind '"\e[1;5C":forward-word'

# user profile
[[ "$PROFILE_SOURCED" != 1 ]] && source $HOME/.profile

# lutris custom wine
[[ -f $HOME/.winelutris ]] && source $HOME/.winelutris

# load my own aliases
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# finally. paint the terminal emulator!
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
