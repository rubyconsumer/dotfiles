# bash login-shell entry point: portable profile first, then bash-only layers.

[ -f "$HOME/.profile" ] && . "$HOME/.profile"

dotfiles_debug ".bash_profile: loading"

# iTerm2 shell integration (if installed)
test -e "$HOME/.iterm2_shell_integration.bash" && . "$HOME/.iterm2_shell_integration.bash"

# bash-specific config; everything here is what a zsh port must replace
[ -f "$HOME/.shell/bash/options.bash" ] && . "$HOME/.shell/bash/options.bash"
[ -f "$HOME/.shell/bash/completion.bash" ] && . "$HOME/.shell/bash/completion.bash"
[ -f "$HOME/.shell/bash/prompt.bash" ] && . "$HOME/.shell/bash/prompt.bash"

# Deliberately not exported: nested interactive shells re-source via .bashrc
# to get aliases and functions back.
DOTFILES_LOADED=1

dotfiles_debug ".bash_profile: finished"
