export EDITOR="vim"
export ZPLUG_HOME=$HOME/.zplug

safesource() {
  if [[ -f "$1" ]]; then
    source $1
  fi
}
# user profile
[[ $PROFILE_SOURCED != 1 ]] && safesource $HOME/.profile

# lutris custom wine
safesource $HOME/.winelutris

# zplug initialization
[[ ! -f $ZPLUG_HOME/init.zsh ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
safesource $ZPLUG_HOME/init.zsh

# do self-manage
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# load nice libs from oh-my-zsh
zplug "lib/completion",   from:oh-my-zsh
zplug "lib/history",      from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/termsupport",  from:oh-my-zsh
zplug "lib/directories",  from:oh-my-zsh

# for speed debug. mine ? 230ms, not bad tho
# zplug "paulmelnikow/zsh-startup-timer"

# naisu minimal theme
mnml_entry() {
  echo -n "%{\e[1m%}::%{\e[21m%}"
}
MNML_OK_COLOR="1"
MNML_USER_CHAR="[ %{\e[1m%}$USER%{\e[21m%} ]"
MNML_PROMPT=(mnml_status mnml_ssh mnml_pyenv mnml_entry)
zplug 'subnixr/minimal', use:minimal.zsh, as:theme

# auto-close quotes and brackets like a pro
zplug 'hlissner/zsh-autopair', defer:2

# another eyecandy
zplug 'zdharma/fast-syntax-highlighting', defer:2, hook-load:'FAST_HIGHLIGHT=()'

# finally install and load those plugins
zplug check || zplug install
zplug load

# returning command and folder completion when line is empty
# like a bash, but better
blanktab() { [[ $#BUFFER == 0 ]] && CURSOR=3 zle list-choices || zle expand-or-complete }
zle -N blanktab && bindkey '^I' blanktab

# On-demand rehash
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd

# load my own aliases
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# finally. paint the terminal emulator!
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
