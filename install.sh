#!/usr/bin/env bash
#
# simple deploy script for dotfiles
#
#  usage :
#   ./install.sh <module-name>
#

dotfiles=$(realpath $(dirname $0))
mod=$(basename $(realpath $1))

fun_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

if [[ ! -f $dotfiles/$mod/.moduleinst ]]; then
    echo ":: .moduleinst for $mod doesn't exists. aborting"
    exit 1
fi

source $dotfiles/$mod/.moduleinst

if fun_exists module_install; then
    echo ":: using custom install method for $mod"
    module_install
    exit $?
fi

target=$(realpath -m $module_target)
if fun_exists module_preinstall; then
    module_preinstall
fi

echo "installing $mod to $target"

[[ "$module_use_sudo" == "true" ]] && PREFX="sudo" || PREFX=""
$PREFX mkdir -p $target
$PREFX cp -af $dotfiles/$mod/. $target/
$PREFX rm $target/.moduleinst

if fun_exists module_postinstall; then
    module_postinstall
fi
