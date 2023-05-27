#!/usr/bin/env bash
#
# simple deploy script for dotfiles
#
#  usage :
#   ./dot.sh <module-name>
#

dotfiles=$(realpath "$(dirname "$0")")

log() {
    printf "$(basename "$0"): %s\n" "$1"
}

fun_exists() {
    declare -f -F $1 >/dev/null
    return $?
}

usage() {
    cat <<EOF
Dotfiles install script

Usage :
  $(basename "$0") [module-name]

EOF
}

comm_prefix_gen() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1" >/dev/null 2>&1
        if [ $? != 0 ]; then
            sudo mkdir -p "$1" >/dev/null 2>&1
            printf sudo
        fi
    else
        local curr=$(id -gn)
        local dest=$(stat -c %G "$1")
        if [ "$dest" != "$curr" ]; then
            printf sudo
        fi
    fi
}

deploy() {
    local src=$1
    local dest=$2
    local comm_prefix=$(comm_prefix_gen "$dest")

    if [ "$comm_prefix" = "sudo" ]; then
        log "using sudo to install module..."
    fi

    find "$src" -type f | while read f_src; do
        [ "${f_src#*.install}" != "$f_src" ] && continue
        [ "${f_src#*.install.ps1}" != "$f_src" ] && continue
        [ "${f_src#*README.md}" != "$f_src" ] && continue

        f_dest="$(printf ${f_src%/*} | sed "s|$src|$dest|")"
        log "copying $f_src to $f_dest"
        [ -d "$f_dest" ] || $comm_prefix mkdir -p "$f_dest"
        $comm_prefix cp "$f_src" "$f_dest"
    done
}

install_mod() {
    local target="$(realpath $1)"
    local name=$(basename $(realpath $target))
    local inst="$target/.install"

    if [ ! -f "$inst" ]; then
        log ".install for $name doesn't exists. aborting"
        exit 1
    fi

    unset dot_preinstall dot_install dot_postinstall module_target
    . $inst
    if fun_exists dot_preinstall; then
        dot_preinstall
    fi

    if fun_exists dot_install; then
        log "using custom install method for topic $name"
        dot_install
    else
        local dest=$(realpath -mq "$module_target")
        if [ -z "$dest" ]; then
            log "Invalid module_target entry. aborting"
            exit 1
        fi

        log "installing topic $name to $dest"
        deploy "$target" "$dest"
    fi

    if fun_exists dot_postinstall; then
        dot_postinstall
    fi
}

if [ -z "$1" ]; then
    usage
    exit 1
fi

for mod in $@; do
    install_mod "$mod"
done
