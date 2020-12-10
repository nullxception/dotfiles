# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# check if zinit is not exists
ZINITDIR=$ZDOTDIR/.zinit
[[ -f $ZINITDIR/bin/zinit.zsh ]] || {
    mkdir -p $ZINITDIR/bin
    git clone --depth=1 https://github.com/zdharma/zinit.git $ZINITDIR/bin
}

# Initialize zinit
source $ZINITDIR/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Theme
MNML_USER_CHAR="[ $USER ]"
MNML_INSERT_CHAR='.//'
zinit ice wait='!' lucid
zinit depth=1 for subnixr/minimal

# Plugins
zinit wait depth=1 lucid for \
    hlissner/zsh-autopair \
    atinit="zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting

# Snippets
zinit lucid light-mode for \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::termsupport.zsh

# returning command and folder completion when line is empty
# like a bash, but better
blanktab() { [[ $#BUFFER == 0 ]] && CURSOR=3 zle list-choices || zle expand-or-complete }
zle -N blanktab && bindkey '^I' blanktab

# On-demand rehash for pacman
if command -v pacman > /dev/null; then
    zshcache_time="$(date +%s%N)"
    rehash_precmd() {
        [[ -a /var/cache/zsh/pacman ]] || return
        local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
        if (( zshcache_time < paccache_time )); then
            rehash && zshcache_time="$paccache_time"
        fi
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook -Uz precmd rehash_precmd
fi

# load command aliases
[[ -f $ZDOTDIR/.aliases ]] && source $ZDOTDIR/.aliases || true

# lutris custom wine
[[ -f $XDG_DATA_HOME/lutris/env ]] && source $XDG_DATA_HOME/lutris/env || true

# finally. paint the terminal emulator!
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &) || true
