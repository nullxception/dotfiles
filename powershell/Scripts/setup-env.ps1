#
# nullxception's desktop enviroment setup
# usage:
# ./install.ps1 <module-name>
#

if (!(Get-Command scoop)) {
    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop install gsudo
gsudo config CacheMode Auto

# Git need to be installed on system-wide for scoop update
sudo scoop install --global git

# Setup aria2 for the scoop downloader
scoop install aria2
scoop config aria2-enabled true

# Setup buckets
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
scoop bucket add retools https://github.com/TheCjw/scoop-retools.git
scoop bucket add spotify https://github.com/TheRandomLabs/Scoop-Spotify.git

# Apps, fonts, runtime, etc
scoop install `
    7zip `
    adopt11-hotspot `
    autohotkey `
    bat `
    jadx `
    less `
    lsd `
    neovim `
    python `
    ripgrep `
    spotify-latest

sudo scoop install --global JetBrainsMono-NF
sudo "$(scoop prefix python)\install-pep-514.reg"

# Register several path to machine path
sudo Register-Path -Scope Machine $(scoop prefix python)
sudo Register-Path -Scope Machine $(scoop prefix python)\Scripts
sudo Register-Path -Scope Machine $(scoop prefix python)\Scripts
sudo Register-Path -Scope Machine $(scoop prefix adopt11-hotspot)\bin
