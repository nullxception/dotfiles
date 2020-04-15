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

read -p 'Name: ' name
read -p 'email: ' email
read -p 'Git credential cache time (in hours): ' $pwdtime

git config --global user.name "$name"
git config --global user.email "$email"

if [[ $pwtime -gt 0 ]]; then
    git config --global credential.helper "cache --timeout $((3600 * pwtime))"
else
    git config --global --unset credential.helper
fi

git config --global merge.renamelimit 999999
git config --global diff.renameLimit 999999
git config --global alias.merge 'merge --no-ff'
git config --global alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'

log "done!"
