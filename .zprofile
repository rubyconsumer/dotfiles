# zsh login-shell entry point: load the shared portable profile
# (env, aliases, mac layer). Interactive setup lives in .zshrc.

[ -f "$HOME/.profile" ] && . "$HOME/.profile"
