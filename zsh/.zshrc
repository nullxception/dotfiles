# If not running interactively, don't do anything
[[ $- != *i* ]] && return

setopt extended_glob
typeset -Ag ZI
ZSCRIPT_HOME="$HOME/.zsh"
ZI[HOME_DIR]="${ZSCRIPT_HOME}/zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
ZI[COMPINIT_OPTS]=-C

if [ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]; then
    command mkdir -p "${ZI[BIN_DIR]}"
    command chmod go-rwX "${ZI[HOME_DIR]}"
    command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "${ZI[BIN_DIR]}"
fi

source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit_fast

# Plugins
zi wait depth=1 lucid light-mode for \
    hlissner/zsh-autopair \
    atinit"zicompinit_fast; zicdreplay" \
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
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" || "$ARCH" == "aarch64" ]];then    
    # ripgrep
    zi ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
    zi light BurntSushi/ripgrep

    # bat
    zi ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zi light sharkdp/bat

    # fzf
    zi ice as"program" from"gh-r"
    zi light junegunn/fzf

	# eza
	zi ice as"program" from"gh-r" pick"eza"
	zi light eza-community/eza

	# sharkdp/fd
	zi ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
	zi light sharkdp/fd
fi

# Theme
if [ -n "$SSH_TTY" ]; then
	ROUNDY_USER_CONTENT_NORMAL=" %n@${HOSTNAME:-$HOST} "
	ROUNDY_USER_CONTENT_ROOT=" %n@${HOSTNAME:-$HOST} "
fi
zi ice pick="lib/async.zsh" src="roundy.zsh" compile"{lib/async,roundy}.zsh"
zi light nullxception/roundy

# Load hooks from ~/.zsh/after (just like ~/.config/nvim/after/plugin)
for afterfile in "$ZSCRIPT_HOME/after"/**/*(.); do
    source $afterfile || true
done

