$InstallTarget = "$env:LOCALAPPDATA\nvim"
function PostInstall-Dotfiles {
    Invoke-WebRequest "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -OutFile "$env:LOCALAPPDATA\nvim-data\site\autoload\plug.vim"
    nvim +PlugInstall +qall
}
