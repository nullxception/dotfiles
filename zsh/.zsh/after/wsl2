[ -z "$WSL_INTEROP" ] && return 0

export WSL_HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
add_path $HOME/.local/bin/wsl

# WSL2 workaround for default dir
grep -qE '/mnt/c/Users/([a-zA-Z\ ]+)$' <<<$PWD &&
    grep -qE '/mnt/c/Users/([a-zA-Z\ ]+)$' <<<$OLDPWD &&
    cd ~

if command -v link-android-tools >/dev/null; then
    link-android-tools
fi
