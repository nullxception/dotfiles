$InstallTarget = "$env:LOCALAPPDATA\nvim"
function PostInstall-Dotfiles {
    nvim +PlugInstall +qall
}
