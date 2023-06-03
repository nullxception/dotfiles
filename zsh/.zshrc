# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZSCRIPT_HOME="$HOME/.zsh"
typeset -Ag ZI
ZI[HOME_DIR]="${ZSCRIPT_HOME}/zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"

if [ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]; then
    command mkdir -p "${ZI[BIN_DIR]}"
    command chmod go-rwX "${ZI[HOME_DIR]}"
    command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "${ZI[BIN_DIR]}"
fi

source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

# Plugins
zi wait depth=1 lucid light-mode for \
    hlissner/zsh-autopair \
    atinit"zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

# Snippets
zi lucid light-mode for \
    OMZL::functions.zsh \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::termsupport.zsh

# Programs
if [[ "$(uname -m)" == "x86_64" ]];then
    # ripgrep
    zi ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
    zi light BurntSushi/ripgrep

    # exa
    zi ice as"command" from"gh-r" bpick"exa-linux-x86_64-musl-*" pick"bin/exa"
    zi light ogham/exa

    # bat
    zi ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zi light sharkdp/bat

    # sharkdp/fd
    zi ice as"command" from"gh-r" mv"fd* -> fd" bpick"*x86_64-unknown-linux-gnu*" pick"fd/fd"
    zi light sharkdp/fd

    # fzf
    zi ice from"gh-r" as"program"
    zi light junegunn/fzf
fi

# Theme
zi ice pick="lib/async.zsh" src="roundy.zsh" compile"{lib/async,roundy}.zsh"
zi light nullxception/roundy

# Load hooks from ~/.zsh/after (just like ~/.config/nvim/after/plugin)
for afterfile in "$ZSCRIPT_HOME/after"/**/*(.); do
    source $afterfile || true
done

