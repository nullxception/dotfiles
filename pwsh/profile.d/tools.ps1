$InstallToolsVersion = "1.0.0"
$InstallToolsMarker = "$env:LOCALAPPDATA\pwsh-install-tools.dat"

function Set-GitDefaults {
    Update-CurrentEnv
    git config --global merge.renamelimit 999999
    git config --global diff.renameLimit 999999
    git config --global alias.merge 'merge --no-ff'
    git config --global alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'
    git config --global core.autocrlf input
    git config --global core.eol lf
}

function Install-Tools {
    if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
        Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    }

    scoop install 7zip
    reg import "$(scoop prefix 7zip)\install-context.reg"

    scoop install gsudo
    gsudo config CacheMode Auto

    scoop install git
    Set-GitDefaults

    scoop install python
    reg import "$(scoop prefix 7zip)\install-pep-514.reg"

    scoop install vcredist2022
    scoop install mingw
    scoop install zig

    scoop bucket add extras
    scoop bucket add nerd-fonts
    scoop bucket add retools https://github.com/TheCjw/scoop-retools.git
    
    scoop install aria2
    scoop install bat
    scoop install bind
    scoop install eza
    scoop install fnm
    scoop install fzf
    scoop install gpg
    scoop install less
    scoop install neovim
    scoop install nssm
    scoop install ripgrep
    scoop install stylua
    scoop install wezterm
    reg import "$(scoop prefix wezterm)\install-context.reg"

    $InstalledScoops = scoop list 6>$null
    if (!($InstalledScoops | Select-String -Pattern "JetBrainsMono-NF" -Quiet -ErrorAction SilentlyContinue)) {
        scoop install JetBrainsMono-NF
    }
}

if (!(Test-Path $InstallToolsMarker) -or (Get-Content $InstallToolsMarker) -ne $InstallToolsVersion) {
    Install-Tools
    Set-Content $InstallToolsMarker $InstallToolsVersion
    Update-CurrentEnv
}

if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias ls eza
}

if (Get-Command nvim -ErrorAction SilentlyContinue) {
    Set-Alias vim nvim
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias cat bat
}

if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}