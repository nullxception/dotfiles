mkcd(){
  mkdir -p "$1"
  cd "$1"
}

# For applying patch from github/gitlab commit url
urlam() {
    local patch=/tmp/urlam--$USER.patch
    local uri=$(cut -d\# -f1 <<<$1)
    echo "urlam: Applying patch from $uri"
    curl -o $patch ${uri}.patch
    git am <$patch
}
