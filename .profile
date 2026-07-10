# POSIX login profile — the portable entry point (any unix, any sh).
# bash-specific setup lives in ~/.bash_profile, which sources this first.

[ -f "$HOME/.shell/env.sh" ] && . "$HOME/.shell/env.sh"

dotfiles_debug ".profile: loading"

[ -f "$HOME/.shell/aliases.sh" ] && . "$HOME/.shell/aliases.sh"
[ -f "$HOME/.umich_aliases" ] && . "$HOME/.umich_aliases"
[ -f "$HOME/.shell/ls.sh" ] && . "$HOME/.shell/ls.sh"
[ -f "$HOME/.shell/bundle.sh" ] && . "$HOME/.shell/bundle.sh"

# macOS-local layer
if [ "$(uname)" = "Darwin" ] && [ -f "$HOME/.shell/mac.sh" ]; then
  . "$HOME/.shell/mac.sh"
fi

dotfiles_debug ".profile: finished"
