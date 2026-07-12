# macOS-only setup (POSIX sh). Sourced by ~/.profile when uname is Darwin.

dotfiles_debug "mac.sh: loading"

# Homebrew (sets PATH, MANPATH, INFOPATH)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

path_prepend /usr/local/bin
path_prepend /usr/local/sbin

# Fix rails server issue with older versions of Ruby
# https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Fix for tar and system resources
export COPYFILE_DISABLE=true

# For pkg-config to find libpq.
#   Needed for: Installing pg 1.5.6 with native extensions
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# rg (ripgrep) related aliases
alias ag="echo 'please use rg'; rg " # switch from Silver Searcher (ag) to RipGrep (rg)
alias rga="rg --no-ignore --hidden" # search everything. ignore the ignores. search hidden files.

alias set_displays='displayplacer "id:4D76F0E0-FCF9-4F0D-83FF-C1A7901AE09A res:3840x2160 hz:60 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0" "id:361F4CF2-BA40-4B79-8889-C1667EEB8111 res:2160x3840 hz:60 color_depth:8 enabled:true scaling:off origin:(-2160,-1212) degree:270" "id:39227EBC-331A-4C81-8211-8DE731EA7B32 res:1440x2560 hz:60 color_depth:8 enabled:true scaling:off origin:(3840,0) degree:270"'

# replacement netstat cmd to find ports used by apps on OS X
alias netstat_osx="sudo lsof -i -P"

# haml lint: lint files with new changes
alias hlint="git diff-tree -r --no-commit-id --name-only 'origin/master..HEAD' | xargs ls -1 2>/dev/null | grep '\.haml$' | xargs bundle exec haml-lint"

# rails start: clean up log files and start rails server
alias rstart="s s s s s rm log/development.log; rm log/test.log; rails s -p 3000"

# export machine-local secrets (gitignored; create by hand on each machine)
[ -f "$HOME/.shell/secret-export.sh" ] && . "$HOME/.shell/secret-export.sh"

[ -f "$HOME/.shell/mac-git.sh" ] && . "$HOME/.shell/mac-git.sh"
[ -f "$HOME/.shell/mac-node.sh" ] && . "$HOME/.shell/mac-node.sh"
[ -f "$HOME/.shell/mac-postgres.sh" ] && . "$HOME/.shell/mac-postgres.sh"
[ -f "$HOME/.shell/mac-ruby.sh" ] && . "$HOME/.shell/mac-ruby.sh"

dotfiles_debug "mac.sh: finished"
