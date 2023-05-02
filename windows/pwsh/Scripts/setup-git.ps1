#
# setup-git
# a helper script to setup git for the first time
#

$CurrentName = git config --global user.name
$CurrentEmail = git config --global user.email

Write-Host "Configuring git"
Write-Host "Previous user was : $CurrentName <$CurrentEmail>"

$name = Read-Host 'Name (leave blank to skip)'
$email = Read-Host 'email (leave blank to skip)'

if (![string]::IsNullOrEmpty($name)) { git config --global user.name "$name" }
if (![string]::IsNullOrEmpty($email)) { git config --global user.email "$email" }

git config --global merge.renamelimit 999999
git config --global diff.renameLimit 999999
git config --global alias.merge 'merge --no-ff'
git config --global alias.onelog 'log --oneline --pretty=format:\"%h # %ai %s\"'
git config --global alias.onebase 'log --oneline --pretty=format:\"GIT_COMMITTER_DATE=\\\"%ci\\\" GIT_AUTHOR_DATE=\\\"%ai\\\" git cherry-pick %h # %s\"'

Write-Host "done!"
