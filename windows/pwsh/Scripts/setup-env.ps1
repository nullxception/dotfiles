#
# nullxception's desktop enviroment setup
#

if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}
else {
    "scoop is already installed"
}

function on_winget($com, $id, $then = {}) {
    if (!(Get-Command $com -ErrorAction SilentlyContinue)) {
        winget install --scope machine -e $id
        Update-CurrentEnv
        & $then
    }
    else {
        "$com is already installed"
    }
}

function on_scoop($com, $id, $then = {}) {
    if (!(Get-Command $com -ErrorAction SilentlyContinue)) {
        scoop install $id
        Update-CurrentEnv
        & $then
    }
    else {
        "$com is already installed"
    }
}


on_winget gsudo gerardog.gsudo {
    gsudo config CacheMode Auto
}

on_winget git Git.Git {
    # Cleanup Git context menus
    gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\Directory\shell\git_gui
    gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\Directory\shell\git_shell
    gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\LibraryFolder\background\shell\git_gui
    gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKCR:\LibraryFolder\background\shell\git_shell
    gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKLM:\SOFTWARE\Classes\Directory\background\shell\git_gui
    gsudo Remove-Item -Force -ErrorAction SilentlyContinue -Path HKLM:\SOFTWARE\Classes\Directory\background\shell\git_shell
}

on_winget 7z 7zip.7zip
on_winget AutoHotkey Lexikos.AutoHotkey
on_winget python3 Python.Python.3

on_scoop aria2c aria2 {
    scoop config aria2-enabled true
}

scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add retools https://github.com/TheCjw/scoop-retools.git

on_scoop bat bat
on_scoop jadx jadx
on_scoop less less
on_scoop lsd lsd
on_scoop nssm nssm
on_scoop nvim neovim
on_scoop rg ripgrep

gsudo scoop install --global JetBrainsMono-NF
