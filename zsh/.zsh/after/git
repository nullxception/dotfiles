command -v git >/dev/null || return 0

# check and set global config (no override)
_git_global_set() {
    git config get --global $1 >/dev/null || git config set --global $1 $2
}
_git_global_set alias.merge 'merge --no-ff'
_git_global_set alias.onelog 'log --oneline --pretty=format:"%h # %ai %s"'
_git_global_set color.ui auto
_git_global_set core.autocrlf input
_git_global_set core.eol lf
_git_global_set merge.renamelimit 999999

unset -f _git_global_set
