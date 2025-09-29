# Setup PSReadLine
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Colors
Set-PSReadLineOption -Colors @{
    "Parameter" = [ConsoleColor]::Yellow
    "Operator"  = [ConsoleColor]::DarkYellow
    "Command"   = [ConsoleColor]::DarkBlue
}
