#
# PSReadLine settings
#
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -Colors @{
    "Parameter" = [ConsoleColor]::Yellow
    "Operator"  = [ConsoleColor]::DarkYellow
    "Command"   = [ConsoleColor]::DarkBlue
}
Set-PSReadLineKeyHandler -Key "Ctrl+l" -ScriptBlock {
    $hasGit = Get-Command git -ErrorAction SilentlyContinue
    $hasFzf = Get-Command fzf -ErrorAction SilentlyContinue
    if (-not ($hasGit -and $hasFzf)) {
        return
    }
    $isGitTree =  git rev-parse --is-inside-work-tree 2>$null
    if (-not $isGitTree) {
        return
    }
    $item = (
        git for-each-ref --format="%(refname:short)|BRANCH" refs/heads |
            git for-each-ref --format="%(refname:short)|TAG" refs/tags |
            git log --oneline --decorate=short --color=always |
            ForEach-Object { $_ -replace '\x1b\[[0-9;]*m', '' } |
            fzf --ansi --reverse --height 50% --prompt="Git > " --preview "git show --color=always {1}"
    )
    if ($item) {
        $ref = ($item -split '\|')[0]
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($ref -split ' ')[0])
    }
}


#
# Autocomplete
#
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

#
# prompt
#

# Get-InstalledModule is too slow, let's spin our own way
function Test-HasPsModule {
    param(
        [string]$DirName
    )
    $env:PSModulePath -split ":" | ForEach-Object { Join-Path "$_" "$DirName" } |
        Where-Object { Test-Path "$_" } | Select-Object -First 1
}

if (!(Test-HasPsModule posh-git)) {
    Install-Module posh-git -Scope CurrentUser -Force
}

# posh-git will be loaded by lazy-posh-git later
if (!(Test-HasPsModule lazy-posh-git)) {
    Install-Module lazy-posh-git -Scope CurrentUser -Force -AllowClobber
}

Import-Module lazy-posh-git -ErrorAction SilentlyContinue

function Get-GitBranch {
    if (!(Get-Command git -ErrorAction SilentlyContinue) -or !(Test-Path .git\HEAD)) {
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
    $Local:user = $env:USERNAME ?? $env:USER ?? "me"
    $Local:dirInfo = $PWD.Path.Replace($env:USERPROFILE, "~")
    if ($Local:dirInfo -ne "~") {
        $Local:dirInfo = Split-Path $Local:dirInfo -Leaf
    }
    $Local:gitBranch = Get-GitBranch
    if (![string]::IsNullOrWhiteSpace($Local:gitBranch)) {
        $Local:git = " $ESC[32m($Local:gitBranch)$ESC[0m"
    }
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    "${osc7}$ESC[31m$Local:user$ESC[34m at $ESC[0m$Local:dirInfo$Local:git > "
}

#
# Aliases and shims
#
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias -Option AllScope ls eza
}

if (Get-Command nvim -ErrorAction SilentlyContinue) {
    Set-Alias -Option AllScope vim nvim
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Option AllScope cat bat
}

if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}

#
# fzf setup
#
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    if (!(Test-HasPsModule PSFzf)) {
        Install-Module PSFzf -Scope CurrentUser -Force
    }
    Import-Module PSFzf
}
