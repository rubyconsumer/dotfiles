# Portable aliases and functions (POSIX sh).

dotfiles_debug "aliases.sh: loading"

alias s='echo;echo;echo;'
alias cman="nroff -man"

# git
git_current_branch() {
  git branch --show-current 2>/dev/null
}
alias gpsup='git push --set-upstream origin $(git_current_branch)'

# Example:
# sleep 9000
# hunt sleep
hunt() {
  ps uawwwx | grep $1 | grep -v grep
}

# Example:
# sleep 9000
# hunt2kill sleep
hunt2kill() {
  ps uawwwx | grep $1 | grep -v grep | tr -s ' ' | cut -f2 -d' ' | xargs kill -9
}
