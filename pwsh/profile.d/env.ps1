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
            'Process' { $names = Get-ChildItem Env:\ | Select-Object -ExpandProperty Key }
            'Machine' { $names = Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | Select-Object -ExpandProperty Property }
            'User' { $names = Get-Item 'HKCU:\Environment' | Select-Object -ExpandProperty Property }
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

$CustomPath = @(
    "D:\Android\Sdk\cmdline-tools\latest\bin",
    "D:\Android\Sdk\emulator",
    "D:\Android\Sdk\platform-tools"
)

$CustomPath | Where-Object { Register-Path -At $_ -Scope User }