#
# nullxception's Dotfiles install script
# usage:
# ./install.ps1 <module-name>
#
param(
    [Parameter(Mandatory=$True)]
    [String] $Module
)
$DotfilesPath = Split-Path -parent $PSCommandPath
$ModuleData = ".module-data.ps1"

function Install-Mod($Name) {
    $ModuleName = Split-Path $Name -Leaf
    $ModulePath = $DotfilesPath + "\" + $ModuleName

    if ([System.IO.File]::Exists("$ModulePath\$ModuleData")) {
        . "$ModulePath\$ModuleData"
        if (Get-Command 'Install-Dotfiles' -errorAction SilentlyContinue) {
            "Install-Dotfiles declared, running custom install function"
            Install-Dotfiles
        } else {
            Write-Output "installing module $ModuleName to $Installtarget"
            if (![System.IO.Directory]::Exists($Installtarget)) {
                New-Item -ItemType Directory -Path $Installtarget
            }
            Get-ChildItem -Path $ModulePath -Exclude $ModuleData | Copy-Item -Destination $Installtarget -Recurse
        }
        if (Get-Command 'Install-Dotfiles' -errorAction SilentlyContinue) {
            "Removing Install-Dotfiles"
            Remove-Item -Path Function:\Install-Dotfiles
        }
    } else {
        "Module $ModuleName does not exists or has no $ModuleData"
    }
}

Install-Mod $Module
