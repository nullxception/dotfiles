command -v ccache >/dev/null || return 0

# configure ccache
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export CCACHE_MAX_FILES=0
export CCACHE_MAX_SIZE=100G
ccache -M ${CCACHE_MAX_SIZE:=50G} -F ccache ${CCACHE_MAX_FILES:=0} >/dev/null 2>&1
