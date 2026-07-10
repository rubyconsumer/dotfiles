# Node toolchain: Volta manages node/npm versions.

dotfiles_debug "mac-node.sh: loading"

export VOLTA_HOME="$HOME/.volta"
path_prepend "$VOLTA_HOME/bin"
