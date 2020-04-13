export EDITOR="vim"
export ZPLUG_HOME=$HOME/.zplug

# user profile
[[ $PROFILE_SOURCED != 1 ]] && source $HOME/.profile

# zplug initialization
[[ ! -f $ZPLUG_HOME/init.zsh ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh

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
MNML_USER_CHAR="[ $USER ]"
MNML_INSERT_CHAR='.//'
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

# load my own aliases
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# finally. paint the terminal emulator!
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
