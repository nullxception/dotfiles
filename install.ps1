#
# nullxception's Dotfiles install script
# usage:
# ./install.ps1 <module-name>
#
param(
    [Parameter(Mandatory = $True)]
    [String] $Module
)

$ModuleData = ".module-data.ps1"

function Install-Mod($ModulePath) {
    $ModuleName = Split-Path $ModulePath -Leaf

    if ([System.IO.File]::Exists("$ModulePath\$ModuleData")) {
        . "$ModulePath\$ModuleData"
        if (Get-Command 'PreInstall-Dotfiles' -errorAction SilentlyContinue) {
            PreInstall-Dotfiles
        }
        if (Get-Command 'Install-Dotfiles' -errorAction SilentlyContinue) {
            Install-Dotfiles
        }
        else {
            Write-Output "installing module $ModuleName to $Installtarget"
            if (![System.IO.Directory]::Exists($Installtarget)) {
                New-Item -ItemType Directory -Path $Installtarget
            }
            Get-ChildItem -Path $ModulePath -Exclude $ModuleData, .module-data.bash | Copy-Item -Destination $Installtarget -Recurse -Force
        }
        if (Get-Command 'PostInstall-Dotfiles' -errorAction SilentlyContinue) {
            PostInstall-Dotfiles
        }

        # Unregister modules functions
        if (Get-Command 'PreInstall-Dotfiles' -errorAction SilentlyContinue) {
            Remove-Item -Path Function:\PreInstall-Dotfiles
        }
        if (Get-Command 'Install-Dotfiles' -errorAction SilentlyContinue) {
            Remove-Item -Path Function:\Install-Dotfiles
        }
        if (Get-Command 'PostInstall-Dotfiles' -errorAction SilentlyContinue) {
            Remove-Item -Path Function:\PostInstall-Dotfiles
        }
    }
    else {
        "Module $ModuleName does not exists or has no $ModuleData"
    }
}

Install-Mod $Module
