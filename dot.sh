#!/usr/bin/env bash
#
# akane's smol script for deploying dotfiles
#
#  usage :
#   ./dot.sh <module-a> <module-b> ...
#

dotfiles="$(realpath "$(dirname "$0")")"

usage() {
    cat <<EOF
dot.sh - Dotfiles install script

Usage :
  $(basename "$0") [OPTION...] module...

Options:

  -h, --help        Show this help text.
  --dry-run         Perform a trial run with no changes made

EOF
}

simplify_path() {
    if [ "$1" = "-s" ]; then
        local rpath="$(realpath "$2")"
        echo "${rpath#$dotfiles/}"
    elif [ "$1" = "-d" ]; then
        echo "${2/$HOME/\~}"
    fi
}

is_file_ignored() {
    case "${1##*/}" in
        "${ignored_files[@]}") return 0 ;;
    esac
    return 1
}

for i in {0..7}; do
    eval $(printf "c${i}=\"\033[0;3${i}m\"")
done

cR="\033[0m"

log() {
    echo -e "${c5}${TAG:-   }${cR} ${1}${cR}"
}

deploy() {
    local src=$1
    local dest=$2

    find "$src" -type f | while read srcfile; do
        is_file_ignored "$srcfile" && continue
        local destfile="$(printf ${srcfile%/*} | sed "s|$src|$dest|")"
        local srcname="$(simplify_path -s "$srcfile")"
        local destname="$(simplify_path -d "$destfile")"
        log "cp ${c1}$srcname${cR} ${c4}$destname"
        if [ $dry_run -ne 1 ]; then
            [ -d "$destfile" ] || mkdir -p "$destfile"
            cp "$srcfile" "$destfile"
        fi
    done
}

install_mod() {
    local module="$(realpath $1)"
    local modname="$(realpath -- "$module")"
    modname="${modname##*/}"
    local moddefs="$module/.install"

    if [ ! -f "$moddefs" ]; then
        log "${c1}$modname${cR}/${c2}.install${cR} doesn't exists. aborting"
        exit 1
    fi

    unset preinstall postinstall dest
    . $moddefs
    local _dest=$(realpath -mq "$dest")
    if [ -z "$_dest" ]; then
        log "Invalid \$dest. aborting"
        exit 1
    fi

    if declare -F preinstall >/dev/null 2>&1; then
        log "./${c1}$modname${cR}/.install::${c2}preinstall()"
        [ $dry_run -ne 1 ] && preinstall
    fi

    TAG="\r" log "installing ${c1}$modname${cR} to ${c4}$(simplify_path -d "$_dest")"
    deploy "$module" "$dest"

    if declare -F postinstall >/dev/null 2>&1; then
        log "./${c1}$modname${cR}/.install::${c2}postinstall()"
        [ $dry_run -ne 1 ] && postinstall
    fi
}

dry_run=0
ignored_files=(.install{,.ps1} README.md)
parsed=$(getopt --options=h --longoptions=help,dry-run --name "$0" -- "$@")
if [ $? -ne 0 ]; then
    log 'Invalid argument, exiting.' >&2
    exit 1
fi

eval set -- "$parsed"
unset parsed
while true; do
    case "$1" in
        "-h" | "--help")
            usage
            exit
            ;;
        "--dry-run")
            dry_run=1
            shift 2
            break
            ;;
        "--")
            shift
            break
            ;;
    esac
done

if [ -z "$1" ]; then
    usage
    exit 1
fi

modcount=0
for mod in "$@"; do
    [ $modcount -gt 0 ] && printf '\n'
    install_mod "$mod"
    modcount=$((modcount + 1))
done
