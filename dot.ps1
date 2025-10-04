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
    if (!(Test-Path -Path $ModuleRPath -PathType Leaf)) {
        Return "Module $ModuleName does not exists or has no $ModuleData"
    }

    . $ModuleRPath
    if (Get-Command 'preinstall' -errorAction SilentlyContinue) {
        preinstall
    }
    Write-Output "installing module $ModuleName to $dest"
    if (!(Test-Path -Path $dest -PathType Container)) {
        New-Item -ItemType Directory -Path $dest
    }
    Get-ChildItem -Path $ModulePath -Exclude $ModuleData,.install,README.md | Copy-Item -Destination $dest -Recurse -Force
    if (Get-Command 'postinstall' -errorAction SilentlyContinue) {
        postinstall
    }

    # Unregister modules functions
    if (Get-Command 'preinstall' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\preinstall
    }
    if (Get-Command 'postinstall' -errorAction SilentlyContinue) {
        Remove-Item -Path Function:\postinstall
    }
}

Install-Mod $Module
