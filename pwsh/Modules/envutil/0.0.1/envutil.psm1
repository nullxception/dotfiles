function Register-Env {
    param (
        [Parameter(Mandatory = $true)] $Key,
        [Parameter(Mandatory = $true)] $Value,
        [System.EnvironmentVariableTarget] $Scope = 'User'
    )
    $CurrentValue = [Environment]::GetEnvironmentVariable($Key, $Scope)
    if ($CurrentValue -ne $Value) {
        [Environment]::SetEnvironmentVariable($Key, $Value, $Scope)
    }
    Set-Item "Env:\$Key" -Value $Value
}

function Register-Path {
    param (
        [Parameter(Mandatory = $true)] $At,
        [System.EnvironmentVariableTarget] $Scope = 'User'
    )
    $CurrentPath = [Environment]::GetEnvironmentVariable("Path", $Scope).Split(";")
    if ($CurrentPath -notcontains "$At") {
        $CurrentPath += $At
        $CurrentPath = $CurrentPath -join ";"
        [Environment]::SetEnvironmentVariable("Path", $CurrentPath, $Scope)
    }

    # Finally, add it to current session
    if ($env:Path.Split(";") -notcontains $At) {
        $env:Path += ";$At"
    }
}

function Update-CurrentEnv {
    $ignored = @('USERNAME', 'PSModulePath', 'Path')

    'Process', 'Machine', 'User' | ForEach-Object {
        $Scope = $_
        switch ($Scope) {
            'Process' {
                $names = Get-ChildItem Env:\ | Select-Object -ExpandProperty Key
            }
            'Machine' {
                $names = Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | Select-Object -ExpandProperty Property
            }
            'User' {
                $names = Get-Item 'HKCU:\Environment' | Select-Object -ExpandProperty Property
            }
        }
        $names | Where-Object -FilterScript { $ignored -notcontains "$_" } | ForEach-Object {
            $fromSession = Get-Item "Env:\${_}" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Value
            $fromReg = [Environment]::GetEnvironmentVariable($_, $Scope)
            if ($fromReg -ne $fromSession) {
                Set-Item "Env:\${_}" -Value $fromReg
            }
        }
    }

    $allpath = 'Machine', 'User' | ForEach-Object {
        [Environment]::GetEnvironmentVariable('Path', $_) -split ';'
    } | Select-Object -Unique

    $env:Path = $allpath -join ";"
}

function Optimize-UserPath {
    $allpath = [Environment]::GetEnvironmentVariable('Path', "User") -split ';'
    $newpath = $allpath | Where-Object { $_ -ne "" -and (Test-Path $_\*) } | # remove path that has no files inside
        ForEach-Object { $_.Replace($env:LOCALAPPDATA, '%LOCALAPPDATA%') } | # replace C:\Users\<username>\AppData\Local with variable
        Sort-Object -Unique

    [Environment]::SetEnvironmentVariable("Path", $newpath -join ";", "User")
}

