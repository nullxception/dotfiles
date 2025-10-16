#
# nullxception's Dotfiles install script
#
# only support reading from .install file :
#
# module_target_win32=path/to/target
# module_target=path/to/target
#
# for convenience, module_target_win32 can be set to "inherit"
# to use module_target instead. This is useful when the target path
# is same on both win32 and linux.
#
# usage:
# ./dot.ps1 <module>
#
param(
    [Parameter(Mandatory = $True)]
    [String] $Module
)

$ModuleData = ".install"

function Resolve-ModuleTarget {
    $arg = $args[0]
    try {
        $str = Invoke-Expression -Command "`"$arg`""
        return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($str)
    } catch {
        return Invoke-Expression -Command "$arg"
    }
}

function Install-Mod($ModulePath) {
    $ModuleName = Split-Path $ModulePath -Leaf
    $ModuleRPath = Resolve-Path $ModulePath\$ModuleData -ErrorAction SilentlyContinue
    if (!(Test-Path -Path $ModuleRPath -PathType Leaf)) {
        Return "Module $ModuleName does not exists or has no $ModuleData"
    }
    $InstallContent = Get-Content $ModuleRPath

    # $ModuleRPath file contains bash variable `module_target_win32` that act as target path
    # e.g. module_target_win32="$env:LOCALAPPDATA\nvim"
    # so we need to evaluate it in PowerShell somehow
    $target_win32 = $InstallContent | ForEach-Object {
        if ($_ -match '^\s*module_target_win32\s*=\s*"(.*)"\s*$') {
            if ($Matches[1] -eq "inherit") {
                return "inherit"
            }
            return Resolve-ModuleTarget $Matches[1]
        }
    }
    $target_def = $InstallContent | ForEach-Object {
        if ($_ -match '^\s*module_target\s*=\s*"(.*)"\s*$') {
            return Resolve-ModuleTarget $Matches[1]
        }
    }

    if ($target_win32 -and $target_win32 -ne "inherit") {
        $module_target = $target_win32
    } elseif ($target_win32 -eq "inherit" -and $target_def) {
        $module_target = $target_def
    } else {
        Return "Module $ModuleName has no valid module_target"
    }

    Write-Output "installing module $ModuleName to $module_target"
    if (!(Test-Path -Path $module_target -PathType Container)) {
        New-Item -ItemType Directory -Path $module_target
    }
    Get-ChildItem -Path $ModulePath -Exclude $ModuleData,.install,README.md | Copy-Item -Destination $module_target -Recurse -Force
}

Install-Mod $Module
