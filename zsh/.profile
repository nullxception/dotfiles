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

# Idempotent executable path
add_path() {
    case ":$PATH:" in
    *:"$1":*) ;;
    *)
        export PATH="${PATH:+$PATH:}$1"
        ;;
    esac
}

add_path $HOME/.local/bin
add_path $HOME/.local/lib/node/bin
add_path $HOME/.local/lib/flutter/bin
add_path $HOME/.pub-cache/bin
add_path $ANDROID_SDK_ROOT/emulator
add_path $ANDROID_SDK_ROOT/platform-tools
add_path $ANDROID_SDK_ROOT/tools
add_path $ANDROID_SDK_ROOT/tools/bin
