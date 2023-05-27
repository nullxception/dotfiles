#!/usr/bin/env bash
#
# simple deploy script for dotfiles
#
#  usage :
#   ./dot.sh <module-name>
#

dotfiles=$(realpath "$(dirname "$0")")

c0="\033[0;30m"
c1="\033[0;31m"
c2="\033[0;32m"
c3="\033[0;33m"
c4="\033[0;34m"
c5="\033[0;35m"
c6="\033[0;36m"
c7="\033[0;37m"
cR="\033[0m"

log() {
    echo -e "${c5}$(basename "$0")${c0}:${cR} ${1}${cR}"
}

fun_exists() {
    declare -f -F $1 >/dev/null
    return $?
}

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

comm_prefix_gen() {
    if [ ! -d "$1" ]; then
        if [ $dry_run != true ]; then
            mkdir -p "$1" >/dev/null 2>&1
        fi
        if [ $? != 0 ]; then
            if [ $dry_run != true ]; then
                sudo mkdir -p "$1" >/dev/null 2>&1
            fi
            printf sudo
        fi
    else
        local curr=$(id -g)
        local dest=$(stat -c %g "$1")
        if [ "$dest" != "$curr" ]; then
            printf sudo
        fi
    fi
}

simplify_path() {
    if [[ "$1" == "src" ]]; then
        local rpath="$(realpath "$2")"
        echo "${rpath#$dotfiles\/}"
    else
        echo "${2/$HOME/\~}"
    fi
}

is_file_ignored() {
    local ignored=false
    for i in "${ignored_files[@]}"; do
        if [ "${1##*/}" == "$i" ]; then
            ignored=true
            break
        fi
    done

    echo $ignored
}

deploy() {
    local src=$1
    local dest=$2
    local comm_prefix=$(comm_prefix_gen "$dest")

    if [ "$comm_prefix" = "sudo" ]; then
        log "${c3}using sudo to install module..."
    fi

    find "$src" -type f | while read f_src; do
        if [ "$(is_file_ignored "$f_src")" = true ]; then
            continue
        fi

        f_dest="$(printf ${f_src%/*} | sed "s|$src|$dest|")"
        fr_src="$(simplify_path src "$f_src")"
        fr_dest="$(simplify_path dst "$f_dest")"
        log "copying ${c4}$fr_src${cR} to ${c4}$fr_dest"
        if [ $dry_run != true ]; then
            [ -d "$f_dest" ] || $comm_prefix mkdir -p "$f_dest"
            $comm_prefix cp "$f_src" "$f_dest"
        fi
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
        log "running $name::dot_preinstall()"
        if [ $dry_run != true ]; then
            dot_preinstall
        fi
    fi

    if fun_exists dot_install; then
        log "running $name::dot_install()"
        if [ $dry_run != true ]; then
            dot_install
        fi
    else
        local dest=$(realpath -mq "$module_target")
        if [ -z "$dest" ]; then
            log "Invalid module_target entry. aborting"
            exit 1
        fi

        log "installing ${c1}$name"
        deploy "$target" "$dest"
    fi

    if fun_exists dot_postinstall; then
        log "running ${c1}$name${cR}::${c2}dot_preinstall()"
        if [ $dry_run != true ]; then
            dot_postinstall
        fi
    fi
}

main() {
    if [ -z "$1" ]; then
        usage
        exit 1
    fi

    if [ $dry_run == true ]; then
        log "${c4}dry-run${cR} mode ${c2}start"
        echo
    fi

    for mod in $@; do
        install_mod "$mod"
    done

    if [ $dry_run == true ]; then
        log "${c4}dry-run${cR} mode ${c2}finish"
    fi
}

dry_run=false
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
            dry_run=true
            shift 2
            break
            ;;
        "--")
            shift
            break
            ;;
    esac
done

main "$@"
