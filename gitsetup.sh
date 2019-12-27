#!/usr/bin/env bash

echo "Configuring git"
echo "Previous user was : $(git config --global user.name) <$(git config --global user.email)>"
read -p 'Name: ' name
read -p 'email: ' email
git config --global user.name "$name"
git config --global user.email "$email"
git config --global merge.renamelimit 999999
git config --global diff.renameLimit 999999
git config --global alias.merge 'merge --no-ff'
git config --global alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'
echo "done!"