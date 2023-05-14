# Skip the not really helping global compinit (Ubuntu)
skip_global_compinit=1

# user profile for fallback initialization
[ -f ~/.profile ] && source ~/.profile

# semi XDG-compliant zsh setup
ZDOTDIR=${XDG_CONFIG_HOME}/zsh
HISTFILE=${ZDOTDIR}/.zsh_history
