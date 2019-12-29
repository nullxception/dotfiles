#!/usr/bin/env bash
#
# gitsetup.sh
# a helper script to setup git for the first time
#

echo "Configuring git"
echo "Previous user was : $(git config --global user.name) <$(git config --global user.email)>"
read -p 'Name: ' name
read -p 'email: ' email
read -p 'Git credential cache time (in hours): ' $pwdtime
git config --global user.name "$name"
git config --global user.email "$email"
[ $pwtime -gt 0 ] && git config --global credential.helper "cache --timeout $((3600*$pwtime))"
git config --global merge.renamelimit 999999
git config --global diff.renameLimit 999999
git config --global alias.merge 'merge --no-ff'
git config --global alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'
echo "done!"