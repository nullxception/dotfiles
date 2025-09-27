# CLI programs via zi
ARCH=$(uname -m)
[[ "$ARCH" != "x86_64" || "$ARCH" != "aarch64" ]] || return 0

# ripgrep
zi ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zi light BurntSushi/ripgrep

# bat
zi ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zi light sharkdp/bat
alias cat=bat

# fzf
zi ice as"program" from"gh-r"
zi light junegunn/fzf

# eza
zi ice as"program" from"gh-r" pick"eza"
zi light eza-community/eza
alias ls=eza

# fd
zi ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zi light sharkdp/fd
