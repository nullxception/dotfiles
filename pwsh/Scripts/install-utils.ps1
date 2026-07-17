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

$wingetOpts = @(
    '--accept-package-agreements',
    '--accept-source-agreements',
    '--source', 'winget',
    '--silent'
)

$wingetPackages = @(
    'Microsoft.VCRedist.2015+.x64'
    'Rustlang.Rustup'
    '7zip.7zip'
    'Git.Git'
    'gerardog.gsudo'
)

$wingetPackages | ForEach-Object {
    winget install --id $_ @wingetOpts
}

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
scoop config aria2-enabled false
gsudo scoop install -g neovim `
    aria2 `
    bat `
    bind `
    eza `
    fnm `
    fzf `
    gnupg `
    gzip `
    less `
    npiperelay `
    nssm `
    python `
    ripgrep `
    stylua `
    unzip `
    zig `
    JetBrainsMono-NF
