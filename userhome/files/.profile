USER_PATH=("${HOME}/.local/bin"
           "${HOME}/.local/node/bin"
           "${HOME}/.local/android-studio/bin"
           "${HOME}/Android/Sdk/platform-tools/")
PATH=$(printf "%s:"  "${USER_PATH[@]}" | sed -e 's/\/://g;s/:$//g'):$PATH

export OCL_ICD_VENDORS=mesa
export PATH=$(path-dedup $PATH)
export QT_QPA_PLATFORMTHEME=qt5ct
export RADV_PERFTEST=aco
export XDG_CONFIG_HOME="${HOME}/.config"

systemctl --user import-environment PATH OCL_ICD_VENDORS QT_QPA_PLATFORMTHEME RADV_PERFTEST > /dev/null 2>&1
