Get-ChildItem -Path "$PSScriptRoot\profile.d\*.ps1" | Sort-Object Name | ForEach-Object { . $_.FullName }
function Get-GitBranch {
    if (!(Get-Command git -ErrorAction SilentlyContinue) || !(Test-Path .git\HEAD)) {
        return $null
    }

    $headFile = Get-Item .git\HEAD
    if ($global:GitHeadLastWrite -ne $headFile.LastWriteTime) {
        $global:GitHeadLastWrite = $headFile.LastWriteTime
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($branch -eq 'HEAD') {
            $branch = git rev-parse --short HEAD 2>$null
        }
        $global:GitBranch = $branch
    }
    return $global:GitBranch
}

function prompt {
    $ESC = [char]27
    $Local:user = $env:USERNAME.ToLower()
    $Local:dirInfo = $PWD.Path.Replace($env:USERPROFILE, "~")
    $Local:gitBranch = Get-GitBranch
    if (![string]::IsNullOrWhiteSpace($Local:gitBranch)) {
        $Local:git = " $ESC[32m($Local:gitBranch)$ESC[0m"
    }
    "$ESC[31m$Local:user$ESC[34m at $ESC[0m$Local:dirInfo$Local:git > "
}
