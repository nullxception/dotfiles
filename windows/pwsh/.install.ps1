$InstallTarget = Split-Path $profile

function Dot-PostInstall {
    if (!(Get-InstalledModule posh-git -ErrorAction SilentlyContinue)) {
        Install-Module posh-git -Scope CurrentUser -Force
    }
    Update-Module posh-git
}
