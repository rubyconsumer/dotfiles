echo "git-mac: loading"

# Git Branch Order by Date (gbod)
alias gbod="git branch-owner | sort -k5n -k2M -k3n -k4n"

# Git Branch Order by Name (gbon): name sort and filtered
alias gbon="git branch-owner | sort -k7 | grep remote | cut -d \" \" -f 8- | grep -v HEAD | grep -v master"

# GIT Configuration
export GIT_EDITOR="mate -w"

