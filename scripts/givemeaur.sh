#!/bin/bash
#
# a helper script to compile AUR Helper that I use extensively
# currently: yay-git

app="yay-git"

if ! command -v git >/dev/null 2>&1; then
    sudo pacman -S git
fi

tmp=$(mktemp -d /tmp/givemeaur-$USER-XXX)
git clone https://aur.archlinux.org/$app.git $tmp
cd $tmp
makepkg -srif
