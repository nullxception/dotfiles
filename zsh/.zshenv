skip_global_compinit=1

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

if ! grep -qe '^prefix=' ~/.npmrc 2>/dev/null; then
    echo "prefix=${HOME}/.local/lib/node" >> $HOME/.npmrc
fi
if ! grep -qe '^cache=' ~/.npmrc 2>/dev/null; then
    echo "cache=${XDG_CACHE_HOME}/npm" >> $HOME/.npmrc
fi

add_path $HOME/.local/share/fnm
if command -v fnm >/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# configure ccache
if command -v ccache >/dev/null; then
    export USE_CCACHE=1
    export CCACHE_EXEC=$(which ccache)
    export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
    export CCACHE_MAX_FILES=0
    export CCACHE_MAX_SIZE=100G
fi

# Check if auth socket is already exists (forwarding, systemd, etc)
if [ ! -e "$SSH_AUTH_SOCK" ]; then
    # use wsl2-ssh-agent if we're on wsl2
    if [ -n "$WSL_INTEROP" ] && command -v wsl2-ssh-agent >/dev/null; then
        eval $(wsl2-ssh-agent)
    elif [ -e "$XDG_RUNTIME_DIR/gcr/ssh" ]; then
        # use provided socket from gnome-keyring's ssh agent component
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
    elif [ -e "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
        # use provided socket (forwarding or systemd ssh-agent)
        # combine with `AddKeysToAgent yes` on ~/.ssh/config
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    elif command -v keychain >/dev/null; then
        # let's try using gentoo's keychain on .zshrc
        export USE_KEYCHAIN=1
    fi
fi

export _zenvpath="$PATH"
