#!/bin/bash
#
# simple deploy script for dotfiles
#
#  usage :
#   ./install.sh <module-name>
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

deploy_topic() {
    local target=$1
    local comm_prefix=$(comm_prefix_gen "$target")
    local moddir="$dotfiles/$mod"

    if [ "$comm_prefix" = "sudo" ]; then
        log "using sudo to install module..."
    fi

    find "$moddir" -type f | while read src; do
        [ "${src#*.module-data.bash}" != "$src" ] && continue
        [ "${src#*.module-data.ps1}" != "$src" ] && continue

        dest="$(printf ${src%/*} | sed "s|$moddir|$target|")/"
        log "copying $src to $dest"
        [ -d "$dest" ] || $comm_prefix mkdir -p "$dest"
        $comm_prefix cp "$src" "$dest"
    done
}

install_mod() {
    local comm_prefix=""
    local mod=$(basename "$(realpath "$1")")

    if [[ ! -f "$dotfiles/$1/.module-data.bash" ]]; then
        log ".module-data.bash for \"$1\" doesn't exists. aborting"
        exit 1
    fi

    source "$dotfiles/$mod/.module-data.bash"
    if fun_exists module_preinstall; then
        module_preinstall
    fi

    if fun_exists module_install; then
        log "using custom install method for topic '$mod'"
        module_install
    else
        local target=$(realpath -mq "$module_target")
        if [ -z "$target" ]; then
            log "Invalid module_target entry. aborting"
            exit 1
        fi

        # Execute install procedure
        log "installing topic '$mod' to $target"
        deploy_topic "$target"
    fi

    # Execute module's post-install
    if fun_exists module_postinstall; then
        module_postinstall
    fi
}

if [[ -z "$@" ]]; then
    usage
    exit 1
fi

install_mod "$1"
