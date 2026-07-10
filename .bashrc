# bash non-login interactive shells: load the full profile once.

if [ -z "${DOTFILES_LOADED:-}" ]; then
  . "$HOME/.bash_profile"
fi
