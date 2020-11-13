#!/bin/bash
#
# simple deploy script for dotfiles
#
#  usage :
#   ./install.sh <module-name>
#

dotfiles=$(realpath $(dirname $0))

log() {
    TAG=$(basename $0)
    printf "$TAG: %s\n" "$1"
}

fun_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

usage() {
cat <<EOF
Dotfiles install script

Usage :
  $(basename $0) [module-name]

EOF
}

if [[ -z "$1" ]];then
    usage
    exit 1
elif [[ ! -f "$dotfiles/$1/.moduleinst" ]]; then
    log ".moduleinst for \"$1\" doesn't exists. aborting"
    exit 1
fi
mod=$(basename $(realpath $1))

source $dotfiles/$mod/.moduleinst

if fun_exists module_install; then
    log "using custom install method for $mod"
    module_install
    exit $?
fi

target=$(realpath -m $module_target)
if fun_exists module_preinstall; then
    module_preinstall
fi

log "installing $mod to $target"

[[ $module_use_sudo == "true" ]] && PREFX="sudo" || PREFX=""
$PREFX mkdir -p $target
$PREFX cp -af $dotfiles/$mod/. $target/
$PREFX rm $target/.moduleinst

if fun_exists module_postinstall; then
    module_postinstall
fi
