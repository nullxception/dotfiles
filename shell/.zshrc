# user profile for fallback initialization (primitive environment cases)
[[ $PROFILE_SOURCED != 1 && -f ~/.profile ]] && source ~/.profile

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# check if zinit is not exists
[[ -d ~/.zinit ]] || mkdir ~/.zinit
[[ -f ~/.zinit/bin/zinit.zsh ]] || git clone https://github.com/zdharma/zinit.git ~/.zinit/bin

# Initialize zinit
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Theme
MNML_USER_CHAR="[ $USER ]"
MNML_INSERT_CHAR='.//'
zinit wait='!' depth=1 lucid for subnixr/minimal

# Plugins
zinit wait depth=1 lucid for \
    hlissner/zsh-autopair \
    atinit="zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting

# Snippets
zinit lucid light-mode for \
    OMZ::lib/completion.zsh \
    OMZ::lib/directories.zsh \
    OMZ::lib/history.zsh \
    OMZ::lib/key-bindings.zsh \
    OMZ::lib/termsupport.zsh

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
[[ -f ~/.aliases ]] && source ~/.aliases

# lutris custom wine
[[ -f ~/.winelutris ]] && source ~/.winelutris

# finally. paint the terminal emulator!
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
