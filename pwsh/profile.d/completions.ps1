Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# Get-InstalledModule is too slow, let's just check the dir instead
$PSProfileDir = Split-Path $PROFILE
if (!(Test-Path "$PSProfileDir\Modules\posh-git" -ErrorAction SilentlyContinue)) {
    Install-Module posh-git -Scope CurrentUser -Force
}
# posh-git will be loaded by lazy-posh-git later
if (!(Test-Path "$PSProfileDir\Modules\lazy-posh-git" -ErrorAction SilentlyContinue)) {
    Install-Module lazy-posh-git -Scope CurrentUser -Force -AllowClobber
}
Import-Module lazy-posh-git -ErrorAction SilentlyContinue
