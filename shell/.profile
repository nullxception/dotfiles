# XDG Base dir specifications
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Application Preferences
export ANDROID_SDK_ROOT="$HOME/.local/lib/android"
export EDITOR="vim"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export USE_CCACHE=1

# Idempotent executable path
if [ "${PATH#*$HOME/.local/bin}" = "$PATH" ]; then
    PATH="$PATH:$HOME/.local/bin"
    PATH="$PATH:$HOME/.local/lib/node/bin"
    PATH="$PATH:$HOME/.local/lib/flutter/bin"
    PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
    PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
    PATH="$PATH:$ANDROID_SDK_ROOT/tools"
    PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"
    export PATH
fi
