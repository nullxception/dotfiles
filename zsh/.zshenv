skip_global_compinit=1

# Load .profile for edge case where .profile is not automatically
# loaded (such as tty)
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

