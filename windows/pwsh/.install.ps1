$InstallTarget = Split-Path $profile

function Dot-PostInstall {
    Install-Module posh-git -Scope CurrentUser -Force
    Update-Module posh-git
}
