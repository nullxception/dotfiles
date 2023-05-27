#
# nullxception's Dotfiles install script
# usage:
# ./dot.ps1 <module-name>
#
param(
    [Parameter(Mandatory = $True)]
    [String] $Module
)

$ModuleData = ".install.ps1"

function Install-Mod($ModulePath) {
    $ModuleName = Split-Path $ModulePath -Leaf
    $ModuleRPath = Resolve-Path $ModulePath\$ModuleData -ErrorAction SilentlyContinue
    if (![System.IO.File]::Exists($ModuleRPath)) {
        Return "Module $ModuleName does not exists or has no $ModuleData"
    }

    . $ModuleRPath
    if (Get-Command 'dot_preinstall' -errorAction SilentlyContinue) {
        dot_preinstall
    }
    if (Get-Command 'dot_install' -errorAction SilentlyContinue) {
        dot_install
    }
    else {
        Write-Output "installing module $ModuleName to $Installtarget"
        if (![System.IO.Directory]::Exists($Installtarget)) {
            New-Item -ItemType Directory -Path $Installtarget
        }
        Get-ChildItem -Path $ModulePath -Exclude $ModuleData, .install | Copy-Item -Destination $Installtarget -Recurse -Force
    }
    if (Get-Command 'dot_postinstall' -errorAction SilentlyContinue) {
        dot_postinstall
    }

    # Unregister modules functions
    if (Get-Command 'dot_preinstall' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\dot_preinstall
    }
    if (Get-Command 'dot_install' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\dot_install
    }
    if (Get-Command 'dot_postinstall' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\dot_postinstall
    }
}

Install-Mod $Module
