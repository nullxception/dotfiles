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
## Hmm, What about random emoji ?
randomojilist=(🐹 🐶 🐺 🦊 🦁 🐻 🐤 🐦 🦉 🐬)
randomoji=${randomojilist[$(($RANDOM%${#randomojilist[@]}+1))]}
ROUNDY_USER_CONTENT_NORMAL=" $randomoji "
ROUNDY_USER_CONTENT_ROOT=" 🐧 " # penguin
zinit ice pick="lib/async.zsh" src="roundy.zsh" compile"{lib/async,roundy}.zsh"
zinit light nullxception/roundy

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

# WSL2 workaround for default dir
grep -qE '/mnt/c/Users/([a-zA-Z\ ]+)$' <<<$PWD \
    && grep -qE '/mnt/c/Users/([a-zA-Z\ ]+)$' <<<$OLDPWD \
    && cd ~
