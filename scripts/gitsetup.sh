#!/bin/bash
#
# gitsetup.sh
# a helper script to setup git for the first time
#

log() {
    TAG=$(basename $0)
    printf "$TAG: %s\n" "$1"
}

log "Configuring git"
log "Previous user was : $(git config --global user.name) <$(git config --global user.email)>"

read -p 'Name (leave blank to skip): ' name
read -p 'email (leave blank to skip): ' email
read -p 'Git credential cache time (in hours. leave blank to skip, 0 to disable): ' $pwdtime

[[ -n "$name" ]] && git config --global user.name "$name"
[[ -n "$email" ]] && git config --global user.email "$email"

if [[ -n "$pwdtime" && $pwtime -gt 0 ]]; then
    git config --global credential.helper "cache --timeout $((3600 * pwtime))"
elif [[ -n "$pwdtime" && $pwtime == 0 ]]; then
    git config --global --unset credential.helper
fi

git config --global merge.renamelimit 999999
git config --global diff.renameLimit 999999
git config --global alias.merge 'merge --no-ff'
git config --global alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'

log "done!"
