function Set-GitDefaults {
    Update-CurrentEnv
    git config --global credential.helper manager-core
    git config --global core.sshCommand "'C:\Windows\System32\OpenSSH\ssh.exe'"
    git config --global merge.renamelimit 999999
    git config --global diff.renameLimit 999999
    git config --global alias.merge 'merge --no-ff'
    git config --global alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'
    git config --global core.autocrlf input
    git config --global core.eol lf
    gsudo {
        $regs = @(
            "HKCR:\Directory\shell\git_gui",
            "HKCR:\Directory\shell\git_shell",
            "HKCR:\LibraryFolder\background\shell\git_gui",
            "HKCR:\LibraryFolder\background\shell\git_shell",
            "HKLM:\SOFTWARE\Classes\Directory\background\shell\git_gui",
            "HKLM:\SOFTWARE\Classes\Directory\background\shell\git_shell"
        )
        $regs | Where-Object { Remove-Item -Force -ErrorAction SilentlyContinue -Confirm -Path $_ }
    }
}

winget install Microsoft.VCRedist.2015+.x64
winget install zig.zig
winget install Python.Python.3.14
winget install Rustlang.Rustup

winget install 7zip.7zip
winget install BurntSushi.ripgrep.MSVC
winget install Git.Git
winget install GnuPG.GnuPG
winget install ISC.Bind
winget install NSSM.NSSM
winget install Neovim.Neovim
winget install Schniz.fnm
winget install aria2.aria2
winget install eza-community.eza
winget install gerardog.gsudo
winget install jftuga.less
winget install junegunn.fzf
winget install sharkdp.bat
winget install jstarks.npiperelay

if ($env:PATH -notlike "*7-Zip*") {
    Register-Path -At "C:\Program Files\7-Zip" -Scope User
}
Update-CurrentEnv
gsudo config CacheMode Auto
Set-GitDefaults

if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}
scoop bucket add extras
scoop bucket add nerd-fonts
scoop install stylua JetBrainsMono-NF
