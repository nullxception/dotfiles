# XDG Base dir specifications
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Application Preferences
export ANDROID_SDK_ROOT="$HOME/.local/lib/android"
export EDITOR="vim"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export QT_QPA_PLATFORMTHEME=qt5ct
export USE_CCACHE=1

# Executable Path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/lib/node/bin"
export PATH="$PATH:$HOME/.local/lib/flutter/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"

export PROFILE_SOURCED=1
