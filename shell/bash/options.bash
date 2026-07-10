# bash shell options and history (bash-only; port to setopt/bindkey for zsh).

dotfiles_debug "options.bash: loading"

# Set Command Line Interface (CLI) to VI mode
set -o vi

# don't put duplicate lines or lines starting with space in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth

# history shows date and time before command
export HISTTIMEFORMAT="%Y-%m-%d %T ~ "

export HISTFILE=$HOME/.history

# Allow Control-S - Control-R in reverse
# Enable (disable) START/STOP output control. Output from the system is stopped when the system receives STOP and started when the system receives START,
#   or if ixany is set, any character restarts output.
stty -ixon
