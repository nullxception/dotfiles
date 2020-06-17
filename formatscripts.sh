#!/bin/bash
dotfiles=$(realpath $(dirname $(basename $0)))

log() {
    TAG=$(basename $0)
    printf "$TAG: %s\n" "$1"
}

find $dotfiles -not -path "$dotfiles/.git/*" -type f | while read f; do
    file=$(realpath --relative-to=. "$f")
    log "checking $file"
    if file "$file" | grep -q "Bourne-Again shell script"; then
        log "formatting $file"
        shfmt -l -w -s -ln bash -i 4 -sr "$file"
    fi
done
