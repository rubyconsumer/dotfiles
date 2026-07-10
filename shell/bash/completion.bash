# bash completion loading (bash-only; zsh uses compinit instead).

dotfiles_debug "completion.bash: loading"

# Homebrew bash-completion (sources everything in etc/bash_completion.d/).
# cdargs' completion file runs zsh's `autoload bashcompinit` whenever $SHELL
# is zsh, even under bash — shim both as no-ops while it loads.
autoload() { :; }
bashcompinit() { :; }
[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && . /opt/homebrew/etc/profile.d/bash_completion.sh
unset -f autoload bashcompinit

# Git completion and __git_ps1 (Apple Command Line Tools ship current copies)
git_core=/Library/Developer/CommandLineTools/usr/share/git-core
[ -r "$git_core/git-completion.bash" ] && . "$git_core/git-completion.bash"
[ -r "$git_core/git-prompt.sh" ] && . "$git_core/git-prompt.sh"
unset git_core
