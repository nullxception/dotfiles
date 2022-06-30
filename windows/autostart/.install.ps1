$InstallTarget = "$env:USERPROFILE\Documents\autostart"
function Dot-PostInstall {
    & $InstallTarget\schedule.ps1
}
