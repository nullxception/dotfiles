#!/bin/bash
dotfiles=$(realpath $(dirname $(basename $0)))
find $dotfiles -not -path "$dotfiles/.git/*" -type f | while read f; do
    echo "checking $(realpath $f)"
    if file "$f" | grep -q "Bourne-Again shell script"; then
        echo "formatting $(realpath $f)"
        shfmt -l -w -s -ln bash -i 4 -sr "$f"
    fi
done
