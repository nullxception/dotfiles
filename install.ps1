#
# nullxception's Dotfiles install script
# usage:
# ./install.ps1 <module-name>
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
    if (Get-Command 'Dot-PreInstall' -errorAction SilentlyContinue) {
        Dot-PreInstall
    }
    if (Get-Command 'Dot-Install' -errorAction SilentlyContinue) {
        Dot-Install
    }
    else {
        Write-Output "installing module $ModuleName to $Installtarget"
        if (![System.IO.Directory]::Exists($Installtarget)) {
            New-Item -ItemType Directory -Path $Installtarget
        }
        Get-ChildItem -Path $ModulePath -Exclude $ModuleData, .install | Copy-Item -Destination $Installtarget -Recurse -Force
    }
    if (Get-Command 'Dot-PostInstall' -errorAction SilentlyContinue) {
        Dot-PostInstall
    }

    # Unregister modules functions
    if (Get-Command 'Dot-PreInstall' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\Dot-PreInstall
    }
    if (Get-Command 'Dot-Install' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\Dot-Install
    }
    if (Get-Command 'Dot-PostInstall' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\Dot-PostInstall
    }
}

Install-Mod $Module
