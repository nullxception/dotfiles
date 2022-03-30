$InstallTarget = "$env:USERPROFILE\Documents\autostart"
function PostInstall-Dotfiles {
    & $InstallTarget\schedule.ps1
}
