if [ ! -f ~/.npmrc ]; then
    cat <<EOF >~/.npmrc
prefix=${HOME}/.local/lib/node
cache=${XDG_CACHE_HOME}/npm
EOF
fi

if command -v fnm >/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
