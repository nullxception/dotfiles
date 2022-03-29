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
git config --global core.sshCommand 'C:/Windows/System32/OpenSSH/ssh.exe'

sudo 'Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service'

Write-Host "Getting wsl-ssh-agent"
$Url = 'https://github.com/rupor-github/wsl-ssh-agent/releases/latest/download/wsl-ssh-agent.zip'
$ZipFile = $env:TEMP + $(Split-Path -Path $Url -Leaf)
$Destination = 'C:\Libraries\wsl-tools'

Invoke-WebRequest -Uri $Url -OutFile $ZipFile
$ExtractShell = New-Object -ComObject Shell.Application
$Files = $ExtractShell.Namespace($ZipFile).Items()
$ExtractShell.NameSpace($Destination).CopyHere($Files)
gsudo Start-Process $Destination
gsudo Register-Path $Destination -Scope Machine

Write-Host "done!"
