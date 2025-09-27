command -v pacman >/dev/null || return 0

# On-demand rehash for pacman
zshcache_time="$(date +%s%N)"
rehash_precmd() {
    [[ -e /var/cache/zsh/pacman ]] || return
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if ((zshcache_time < paccache_time)); then
        rehash && zshcache_time="$paccache_time"
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook -Uz precmd rehash_precmd
