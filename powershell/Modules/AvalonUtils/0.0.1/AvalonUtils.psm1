function Register-Path {
    param (
        [Parameter(Mandatory = $true)] $At,
        [System.EnvironmentVariableTarget] $Scope = 'User'
    )
    $CurrentPath = [Environment]::GetEnvironmentVariable("Path", $Scope)
    if ($CurrentPath.Split(";") -notcontains "$At") {
        [Environment]::SetEnvironmentVariable("Path", $CurrentPath + "$At;", $Scope)
    }

    # Finally, add it to current session
    if ($env:Path.Split(";") -notcontains $At) {
        $env:Path += ";$At"
    }
}

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

function Update-CurrentEnv {
    $ignored = @('USERNAME', 'PSModulePath', 'Path')

    'Process', 'Machine', 'User' | ForEach-Object {
        $scope = $_
        switch ($Scope) {
            'Process' { $names = Get-ChildItem Env:\ | Select-Object -ExpandProperty Key }
            'Machine' { $names = Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | Select-Object -ExpandProperty Property }
            'User' { $names = Get-Item 'HKCU:\Environment' | Select-Object -ExpandProperty Property }
        }
        $names | Where-Object -FilterScript { $ignored -notcontains "$_" } | ForEach-Object {
            $fromSession = Get-Item "Env:\${_}" | Select-Object -ExpandProperty Value
            $fromReg = [Environment]::GetEnvironmentVariable($_, $scope)
            if ($fromReg -ne $fromSession) {
                Set-Item "Env:\${_}" -Value $fromReg
            }
        }
    }

    $env:Path = 'Machine', 'User' | ForEach-Object {
        [Environment]::GetEnvironmentVariable('Path', $_) -split ';'
    } | Select-Object -Unique | Join-String -Separator ";"
}
