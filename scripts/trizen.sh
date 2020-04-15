#!/bin/bash
#
# gitsetup.sh
# a helper script to compile trizen AUR Manager
#

if command -v git > /dev/null 2>&1; then
    sudo pacman -S git
fi

cd /tmp/
rm -rf trizen-git
git clone https://aur.archlinux.org/trizen-git.git
cd trizen-git
makepkg -srif && rm -rf /tmp/trizen-git
