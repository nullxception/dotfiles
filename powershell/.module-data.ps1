$InstallTarget = Split-Path $profile

function PreInstall-Dotfiles {
    if (!(Get-Module posh-git -ErrorAction SilentlyContinue)) {
        "posh-git not installed, installing posh-git powershell module for the Current User..."
        Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
    }
}
