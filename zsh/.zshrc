# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt incappendhistory
setopt sharehistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorealldups
setopt histfindnodups
setopt histsavenodups
setopt histignorespace
setopt histverify

# Suggest correction for mistyped commands
setopt correct

# Better globbing
setopt extendedglob

# Completions
setopt automenu
setopt autolist
setopt completeinword
setopt alwaystoend

eval "$(dircolors -b)"
# fix visibility issues when navigating NTFS on wsl2
export LS_COLORS="ow=0;34:tw=0;36:$LS_COLORS"
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*' menu select

# Navigation keybindings
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -e
bindkey '^[[Z' reverse-menu-complete          # Shift+Tab
bindkey '^[[1;5C' forward-word                # Ctrl+Right move word
bindkey '^[[1;5D' backward-word               # Ctrl+Left move word
bindkey '^[[A' up-line-or-beginning-search    # Up arrow
bindkey "^[OA" up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search  # Down arrow
bindkey "^[OB" down-line-or-beginning-search
bindkey '^[[5~' up-line-or-beginning-search   # PageUp
bindkey '^[[6~' down-line-or-beginning-search # PageDown
bindkey '^[[H' beginning-of-line              # Home
bindkey '^[[F' end-of-line                    # End


# Plugins
zi wait depth=1 lucid light-mode for \
    hlissner/zsh-autopair \
    atinit"zicompinit_fast; zicdreplay" \
    z-shell/F-Sy-H \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

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

