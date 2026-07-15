# zsh interactive shells: shared portable profile + Oh My Zsh.

# Load the portable profile if a login .zprofile hasn't already done so
# in this shell (nested shells need it for aliases and functions).
if [ -z "${DOTFILES_PROFILE_LOADED:-}" ]; then
  [ -f "$HOME/.profile" ] && . "$HOME/.profile"
fi

dotfiles_debug ".zshrc: loading"

# Homebrew zsh completions (must be on fpath before OMZ runs compinit)
if [ -d /opt/homebrew/share/zsh/site-functions ]; then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.shell/zsh/omz-custom"
ZSH_THEME="winstont"
zstyle ':omz:update' mode disabled  # update by hand with: omz update
DISABLE_MAGIC_FUNCTIONS=true  # OMZ's bracketed-paste-magic corrupts pastes in vi-mode
VI_MODE_DISABLE_CLIPBOARD=true  # else vi delete/change ops clobber the system clipboard
plugins=(git vi-mode)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Re-assert our ls aliases over OMZ's lib/directories.zsh versions
[ -f "$HOME/.shell/ls.sh" ] && . "$HOME/.shell/ls.sh"

[ -f "$HOME/.shell/zsh/options.zsh" ] && . "$HOME/.shell/zsh/options.zsh"

dotfiles_debug ".zshrc: finished"
