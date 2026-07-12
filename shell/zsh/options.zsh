# zsh options and keybindings, on top of Oh My Zsh defaults.
# (vi editing mode comes from the OMZ vi-mode plugin; history dedup/timestamps
# and case-insensitive completion come from OMZ's lib defaults.)

dotfiles_debug "options.zsh: loading"

# Ctrl-P / Ctrl-N prefix history search (ported from .inputrc)
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# Allow Control-S - Control-R in reverse (disable XON/XOFF flow control)
[ -t 0 ] && stty -ixon

# cdargs directory bookmarks (cv/cdb/mark); its completion file supports zsh
# via bashcompinit, which needs compinit (run by OMZ) first
if [[ -r /opt/homebrew/etc/bash_completion.d/cdargs-bash.sh ]]; then
  source /opt/homebrew/etc/bash_completion.d/cdargs-bash.sh
fi
