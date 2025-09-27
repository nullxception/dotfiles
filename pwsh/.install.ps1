$module_target = Split-Path $profile

function dot_postinstall {
    if (!(Get-InstalledModule posh-git -ErrorAction SilentlyContinue)) {
        Install-Module posh-git -Scope CurrentUser -Force
    }
    Update-Module posh-git
}
