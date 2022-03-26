#
# nullxception's desktop enviroment setup
# usage:
# ./install.ps1 <module-name>
#

if (!(Get-Command scoop)) {
    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

winget install --scope machine -e Git.Git
winget install --scope machine -e gerardog.gsudo
Update-CurrentEnv
gsudo config CacheMode Auto

winget install --scope machine -e 7zip.7zip
winget install --scope machine -e Git.Git
winget install --scope machine -e GoLang.Go
winget install --scope machine -e Lexikos.AutoHotkey
winget install --scope machine -e Python.Python.3
winget install --scope machine -e vim.vim

# Setup aria2 for the scoop downloader
scoop install aria2
scoop config aria2-enabled true

# Setup buckets
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add retools https://github.com/TheCjw/scoop-retools.git

# Apps, fonts, runtime, etc
sudo scoop install `
    bat `
    jadx `
    less `
    lsd `
    nssm `
    vim `
    ripgrep

gsudo scoop install --global JetBrainsMono-NF
gsudo "$(scoop prefix python)\install-pep-514.reg"

# Register things to $PATH
gsudo Register-Path -Scope Machine "$env:ProgramFiles\7-Zip"
gsudo Register-Path -Scope Machine "$env:ProgramFiles\AutoHotkey"
gsudo Register-Path -Scope Machine "$env:ProgramFiles\Vim\vim82"

# Housekeeping context menus
gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\Directory\shell\git_gui
gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\Directory\shell\git_shell
gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\LibraryFolder\background\shell\git_gui
gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\LibraryFolder\background\shell\git_shell
gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKLM:\SOFTWARE\Classes\Directory\background\shell\git_gui
gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKLM:\SOFTWARE\Classes\Directory\background\shell\git_shell
