# Check if auth socket is already exists (forwarding, systemd, etc)
[ -f "$SSH_AUTH_SOCK" ] && return

# use wsl2-ssh-agent if we're on wsl2
if [ -n "$WSL_INTEROP" ] && command -v wsl2-ssh-agent >/dev/null; then
    eval $(wsl2-ssh-agent)

# let's try using gentoo's keychain
elif command -v keychain >/dev/null; then
    eval $(keychain --eval --quiet id_ed25519)
fi
