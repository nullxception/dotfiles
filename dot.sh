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
    local msg="$(sed "s|$dotfiles/||g; s|$HOME|\~|g" <<<"$1")"
    [ $dry_run -eq 1 ] && echo -ne "${c3}[dryrun] ${cR}"
    echo -e "${c5}${cR}${msg}${cR}"
}

deploy() {
    local src=$1
    local dest=$2

    find "$src" -type f | while read srcfile; do
        is_file_ignored "$srcfile" && continue
        local destfile="$(printf ${srcfile%/*} | sed "s|$src|$dest|")"
        log "  ${c1}$srcfile${cR} -> ${c4}$destfile"
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

    unset module_target
    . $moddefs
    local _dest=$(realpath -mq "$module_target")
    if [ -z "$_dest" ]; then
        log "Invalid \$dest. aborting"
        exit 1
    fi

    log "installing ${c1}$modname${cR} to ${c4}$module_target"
    deploy "$module" "$module_target"
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
