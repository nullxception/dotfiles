$InstallTarget = Split-Path $profile

function PostInstall-Dotfiles {
    Install-Module posh-git -Scope CurrentUser -Force
    Update-Module posh-git
}
