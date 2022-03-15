# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# check if zinit is not exists
ZINITDIR=$ZDOTDIR/zinit
[[ -f $ZINITDIR/bin/zinit.zsh ]] || {
    mkdir -p $ZINITDIR/bin
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git $ZINITDIR/bin
}

# Initialize zinit
source $ZINITDIR/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Theme
zinit ice pick="lib/async.zsh" src="roundy.zsh" compile"{lib/async,roundy}.zsh"
zinit light nullxception/roundy

# Plugins
zinit wait depth=1 lucid for \
    hlissner/zsh-autopair \
    atinit="zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting

# Snippets
zinit lucid light-mode for \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::termsupport.zsh

# Programs
if [[ "$(uname -m)" == "x86_64" ]];then
    # ripgrep
    zinit ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
    zinit light BurntSushi/ripgrep

    # exa
    zinit ice as"command" from"gh-r" bpick"exa-linux-x86_64-musl-*" pick"bin/exa"
    zinit light ogham/exa

    # bat
    zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat

    # sharkdp/fd
    zinit ice as"command" from"gh-r" mv"fd* -> fd" bpick"*x86_64-unknown-linux-gnu*" pick"fd/fd"
    zinit light sharkdp/fd

    # fzf
    zinit ice from"gh-r" as"program"
    zinit light junegunn/fzf
fi

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

# load command aliases and functions
[[ -f $ZDOTDIR/aliases ]] && source $ZDOTDIR/aliases || true
[[ -f $ZDOTDIR/functions ]] && source $ZDOTDIR/functions || true

# configure ccache
ccache -M ${CCACHE_MAX_SIZE:=50G} -F ccache ${CCACHE_MAX_FILES:=0} >/dev/null 2>&1

# Load special scripts for WSL2
if [ -n "$WSL_INTEROP" ]; then
    source $XDG_CONFIG_HOME/wsl2/shellrc
fi
