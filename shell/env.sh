# Portable environment setup (POSIX sh). Sourced first, by ~/.profile.

# Print load tracing when DOTFILES_DEBUG is set (e.g. DOTFILES_DEBUG=1 bash -l).
dotfiles_debug() {
  [ -n "${DOTFILES_DEBUG:-}" ] && echo "$@"
  return 0
}

dotfiles_debug "env.sh: loading"

# Prepend a directory to PATH if it exists and is not already present.
path_prepend() {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

export EDITOR=vi
export PAGER=less
export CDPATH=.:$HOME
umask 0002

# LESS
# -e Causes less to automatically exit the second time it reaches end-of-file.
# -F Causes less to automatically exit if the entire file can be displayed on the first screen.
# -R Causes "raw" control characters to be displayed, but only ANSI "color" escape sequences and OSC 8 hyperlink sequences are output in "raw" form.
# -X Disables sending the termcap initialization and deinitialization strings to the terminal.
export LESS=eFRX

path_prepend "$HOME/.local/bin"
export PATH
