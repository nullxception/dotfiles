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

install_mod() {
    local comm_prefix=""
    local mod=$(basename "$(realpath "$1")")

    if [[ ! -f "$dotfiles/$1/.moduleinst" ]]; then
        log ".moduleinst for \"$1\" doesn't exists. aborting"
        exit 1
    fi

    source "$dotfiles/$mod/.moduleinst"
    target=$(realpath -m "$module_target")
    if fun_exists module_preinstall; then
        module_preinstall
    fi

    if fun_exists module_install; then
        log "using custom install method for $mod"
        module_install
    else
        # Execute module's post-install
        log "installing $mod to $target"
        comm_prefix=$(comm_prefix_gen "$target")
        if [ "$comm_prefix" = "sudo" ]; then
            log "using sudo to install module..."
        fi
        $comm_prefix mv "$mod/.moduleinst" "$dotfiles/.tmp-$mod--mdi"
        $comm_prefix cp -rv "$dotfiles/$mod/." "$target" | sed -e 's/^/:: copying /;s/\.\///g;s/->/to/'
        $comm_prefix mv "$dotfiles/.tmp-$mod--mdi" "$mod/.moduleinst"
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
