# Setup PSReadLine
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Setup additional paths
$CustomPath = @(
    "$env:LOCALAPPDATA\Android\Sdk\cmdline-tools\latest\bin",
    "$env:LOCALAPPDATA\Android\Sdk\emulator",
    "$env:LOCALAPPDATA\Android\Sdk\platform-tools"
)

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

$CustomPath | Where-Object { Register-Path -At $_ -Scope User }

# Setup aliases
Set-Alias ls lsd -Option AllScope
Set-Alias cat bat -Option AllScope
Set-Alias sudo gsudo
Set-Alias vim nvim

# Completions
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# Colors
Set-PSReadLineOption -Colors @{
    "Parameter" = [ConsoleColor]::Yellow
    "Operator"  = [ConsoleColor]::DarkYellow
    "Command"   = [ConsoleColor]::DarkBlue
}

# Prompt
function prompt {
    $ESC = [char]27
    $Local:user = $env:USERNAME.ToLower()
    $Local:dirInfo = $PWD.Path.Replace($env:USERPROFILE, "~")
    if (Get-Command git) {
        $Local:gitBranch = git symbolic-ref --short HEAD
        if (![string]::IsNullOrWhiteSpace($Local:gitBranch)) {
            $Local:git = " $ESC[32m($Local:gitBranch)$ESC[0m"
        }
    }
    "$ESC[31m$Local:user$ESC[34m at $ESC[0m$Local:dirInfo$Local:git > "
}

# late-initialized modules
Import-Module -ErrorAction SilentlyContinue posh-git
