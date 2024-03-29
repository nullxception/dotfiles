# XDG Base dir specifications
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Application Preferences
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
# Fix AVD path for emulator CLI on canary build of studio
# I assume that they're drunk enough to treat $XDG_CONFIG_HOME as $HOME
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
export EDITOR="nvim"
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR="$HOME/.cache/ccache"
export CCACHE_MAX_FILES=0
export CCACHE_MAX_SIZE=100G

# Idempotent executable path
append_path() {
    case ":$PATH:" in
    *:"$1":*) ;;
    *)
        export PATH="${PATH:+$PATH:}$1"
        ;;
    esac
}

append_path $HOME/.local/bin
append_path $HOME/.local/lib/node/bin
append_path $HOME/.local/lib/flutter/bin
append_path $HOME/.pub-cache/bin
append_path $ANDROID_SDK_ROOT/emulator
append_path $ANDROID_SDK_ROOT/platform-tools
append_path $ANDROID_SDK_ROOT/tools
append_path $ANDROID_SDK_ROOT/tools/bin

#
# Load WSL2-specific env
[ -n "$WSL_INTEROP" ] && source "$HOME/.config/wsl2/env"
