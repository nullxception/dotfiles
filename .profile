USER_PATH=("${HOME}/.local/bin"
           "${HOME}/.local/node/bin"
           "${HOME}/.local/android-studio/bin"
           "${HOME}/Android/Sdk/platform-tools/")
PATH=$(printf "%s:"  "${USER_PATH[@]}" | sed -e 's/:$//g'):$PATH

export PATH=$(path-dedup $PATH)
export XDG_CONFIG_HOME="${HOME}/.config"
export OCL_ICD_VENDORS=mesa
