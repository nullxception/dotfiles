# Skip the not really helping global compinit (Ubuntu)
skip_global_compinit=1

# user profile for fallback initialization (primitive environment cases)
[[ $PROFILE_SOURCED != 1 && -f ~/.profile ]] && source ~/.profile

# semi XDG-compliant zsh setup
ZDOTDIR=${XDG_CONFIG_HOME}/zsh
