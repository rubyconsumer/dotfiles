# bash completion loading (bash-only; zsh uses compinit instead).

dotfiles_debug "completion.bash: loading"

# Homebrew bash-completion
[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && . /opt/homebrew/etc/profile.d/bash_completion.sh

# Git completion and __git_ps1 (Apple Command Line Tools ship current copies)
git_core=/Library/Developer/CommandLineTools/usr/share/git-core
[ -r "$git_core/git-completion.bash" ] && . "$git_core/git-completion.bash"
[ -r "$git_core/git-prompt.sh" ] && . "$git_core/git-prompt.sh"
unset git_core
