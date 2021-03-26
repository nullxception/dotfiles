# Setup PSReadLine
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

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

# Prompt with git integration
Import-Module posh-git
function prompt {
    $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
    $GitPromptSettings.EnableFileStatus = $false
    $GitPromptSettings.DefaultPromptSuffix = " > "

    $ESC = [char]27
    $USER = $env:USERNAME.ToLower()
    "$ESC[31m$USER$ESC[34m at $ESC[0m"+ (& $GitPromptScriptBlock)
}
