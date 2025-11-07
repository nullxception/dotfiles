# fix armbian bug where $PATH on .zshenv is getting overwritten
# by armbian's /etc/profile
if [ "${#PATH}" -lt "${#_zenvpath}" ]; then
    export PATH="$_zenvpath:$PATH"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

typeset -Ag ZINIT
ZINIT[COMPINIT_OPTS]=-C
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt incappendhistory
setopt sharehistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorealldups
setopt histfindnodups
setopt histsavenodups
setopt histignorespace
setopt histverify

# Suggest correction for mistyped commands
setopt correct

# Better globbing
setopt extendedglob

# Completions
setopt automenu
setopt autolist
setopt completeinword
setopt alwaystoend

setopt autocd

eval "$(dircolors -b)"
# fix visibility issues when navigating NTFS on wsl2
export LS_COLORS="ow=0;34:tw=0;36:$LS_COLORS"
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*' menu select

# Navigation keybindings
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -e
bindkey '^N' menu-complete                    # Ctrl-n
bindkey '^P' reverse-menu-complete            # Ctrl-p
bindkey '^[[Z' reverse-menu-complete          # Shift-Tab
bindkey '^[[1;5C' forward-word                # Ctrl-Right
bindkey '^[[1;5D' backward-word               # Ctrl-Left
bindkey "^K" up-line-or-beginning-search      # Ctrl-j
bindkey '^[[A' up-line-or-beginning-search    # Up arrow
bindkey "^[OA" up-line-or-beginning-search
bindkey "^J" down-line-or-beginning-search    # Ctrl-k
bindkey '^[[B' down-line-or-beginning-search  # Down arrow
bindkey "^[OB" down-line-or-beginning-search
bindkey '^[[5~' up-line-or-beginning-search   # PageUp
bindkey '^[[6~' down-line-or-beginning-search # PageDown
bindkey '^[[H' beginning-of-line              # Home
bindkey '^[[F' end-of-line                    # End

# On-demand rehash for pacman
if command -v pacman >/dev/null; then
    _zpactime="$(date +%s%N)"
    _zpac_rehash() {
        [[ -e /var/cache/zsh/pacman ]] || return
        local pactime="$(date -r /var/cache/zsh/pacman +%s%N)"
        if ((zshcache_time < pactime)); then
            rehash && _zpactime="$pactime"
            autoload -Uz compinit
            compinit && zi cdreplay -q
        fi
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook -Uz precmd _zpac_rehash
fi

mkcd(){
  mkdir -p "$1"
  cd "$1"
}

# For applying patch from github/gitlab commit url
urlam() {
    local patch=/tmp/urlam--$USER.patch
    local uri=$(cut -d\# -f1 <<<$1)
    echo "urlam: Applying patch from $uri"
    curl -o $patch ${uri}.patch
    git am <$patch
}

# configure ccache
if command -v ccache >/dev/null; then
    ccache -M ${CCACHE_MAX_SIZE:=50G} -F ccache ${CCACHE_MAX_FILES:=0} >/dev/null 2>&1
fi

if command -v git >/dev/null; then
    # check and set global config (no override)
    gitset() {
        git config get --global $1 >/dev/null || git config set --global $1 $2
    }

    gitset alias.merge 'merge --no-ff'
    gitset alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'
    gitset color.ui auto
    gitset core.autocrlf input
    gitset core.eol lf
    gitset merge.renamelimit 999999

    unset -f gitset
fi

# keychain might ask interactively, postpone at the end
if [ "$USE_KEYCHAIN" -eq 1 ]; then
    eval $(keychain --eval --quiet id_ed25519)
fi

# CLI programs via zi
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" || "$ARCH" == "aarch64" ]]; then

    # ripgrep
    if ! command -v rg >/dev/null; then
        zi ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
        zi light BurntSushi/ripgrep
    fi

    # bat
    if ! command -v bat >/dev/null; then
        zi ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
        zi light sharkdp/bat
    else
        alias cat=bat
    fi

    # eza
    if ! command -v eza >/dev/null; then
        zi ice as"program" from"gh-r" pick"eza" atload"alias ls=eza"
        zi light eza-community/eza
    else
        alias ls=eza
    fi

    # fd
    if ! command -v fd >/dev/null; then
        zi ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
        zi light sharkdp/fd
    fi

    # fzf
    if ! command -v fzf >/dev/null; then
        zi ice as"program" from"gh-r" atload"source <(fzf --zsh)"
        zi light junegunn/fzf
    else
        source <(fzf --zsh)
    fi
fi

# Plugins
zi wait depth=1 lucid for \
    @nullxception/roundy \
    @hlissner/zsh-autopair \
    atinit"zicompinit; zicdreplay" @z-shell/F-Sy-H \
    atload"_zsh_autosuggest_start" @zsh-users/zsh-autosuggestions \
    blockf atpull'zi creinstall -q .' @zsh-users/zsh-completions

