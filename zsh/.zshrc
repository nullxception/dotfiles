# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZSCRIPT_HOME="$HOME/.zsh"

# Bootstrap and initialize zinit
ZINIT_HOME=$HOME/.local/share/zinit
ZINIT_GIT=$ZINIT_HOME/zinit.git

if [[ ! -f $ZINIT_GIT/zinit.zsh ]]; then
    mkdir -p "$ZINIT_HOME" && chmod g-rwX "$ZINIT_HOME"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_GIT"
fi

source "$ZINIT_GIT/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Theme
zinit ice pick="lib/async.zsh" src="roundy.zsh" compile"{lib/async,roundy}.zsh"
zinit light nullxception/roundy

# Plugins
zinit wait depth=1 lucid for \
    hlissner/zsh-autopair \
    atinit="zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting

# Snippets
zinit lucid light-mode for \
    OMZL::functions.zsh \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::termsupport.zsh

# Programs
if [[ "$(uname -m)" == "x86_64" ]];then
    # ripgrep
    zinit ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
    zinit light BurntSushi/ripgrep

    # exa
    zinit ice as"command" from"gh-r" bpick"exa-linux-x86_64-musl-*" pick"bin/exa"
    zinit light ogham/exa

    # bat
    zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat

    # sharkdp/fd
    zinit ice as"command" from"gh-r" mv"fd* -> fd" bpick"*x86_64-unknown-linux-gnu*" pick"fd/fd"
    zinit light sharkdp/fd

    # fzf
    zinit ice from"gh-r" as"program"
    zinit light junegunn/fzf
fi

# Load hooks from ~/.zsh/after (just like ~/.config/nvim/after/plugin)
for afterfile in "$ZSCRIPT_HOME/after"/**/*(.); do
    source $afterfile || true
done
