$InstallTarget = "$env:USERPROFILE\Documents\autostart"
function dot_postinstall {
    & $InstallTarget\schedule.ps1
}
