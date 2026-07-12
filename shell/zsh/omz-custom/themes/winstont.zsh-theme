# winstont.zsh-theme — zsh port of the bash prompt in shell/bash/prompt.bash
# (fill line with date/time, user@host:path, git branch + dirty flags +
# minutes-since-last-commit timer).

setopt PROMPT_SUBST

WT_RED=$'\e[0;31m'
WT_YELLOW=$'\e[1;33m'
WT_GREEN=$'\e[0;32m'
WT_PURPLE=$'\e[1;35m'
WT_CYAN=$'\e[1;36m'
WT_WHITE=$'\e[1;37m'
WT_DARK_GRAY=$'\e[1;30m'
WT_GRAY=$'\e[0;90m'
WT_RESET=$'\e[0m'

wt_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

wt_git_dirty() {
  local gs bitsum bitind
  [[ -n $(wt_git_branch) ]] || return 0
  gs=$(git status 2> /dev/null)
  bitsum=''
  bitind=''

  # Summary statuses
  [[ $gs == *"have diverged"* ]]                 && bitsum="${bitsum}⎇ "
  [[ $gs == *"Your branch is ahead of"* ]]       && bitsum="${bitsum}⇧ "
  [[ $gs == *"Changes to be committed"* ]]       && bitsum="${bitsum}✓ "
  [[ $gs == *"Changes not staged for commit"* ]] && bitsum="${bitsum}± "
  [[ $gs == *"Untracked files"* ]]               && bitsum="${bitsum}⚐ "

  # Individual file statuses
  [[ $gs == *"modified:"* ]] && bitind="${bitind}~ "
  [[ $gs == *"renamed:"* ]]  && bitind="${bitind}➔ "
  [[ $gs == *"new file:"* ]] && bitind="${bitind}+ "
  [[ $gs == *"deleted:"* ]]  && bitind="${bitind}- "

  if [[ -n $bitsum && -n $bitind ]]; then
    bitsum="${bitsum}( "
    bitind="${bitind})"
  fi
  [[ -n "${bitsum}${bitind}" ]] && echo "${bitsum}${bitind} "
}

wt_git_timer() {
  local last mins color
  [[ -n $(wt_git_branch) ]] || return 0
  last=$(git log --pretty=format:'%ct' -1 2> /dev/null)
  [[ -n $last ]] || return 0
  mins=$(( ($(date +%s) - last) / 60 ))
  if (( mins > 40 )); then
    color=$WT_RED
  elif (( mins > 15 )); then
    color=$WT_YELLOW
  else
    color=$WT_GREEN
  fi
  echo "${color}(${mins}m) "
}

# Recompute the fill line to the current terminal width (bash prompt_command)
wt_prompt_fill() {
  local n=$(( COLUMNS - 20 ))
  (( n < 0 )) && n=0
  WT_FILL=${(pl:$n::-:)}
}

# Reset color before command output (bash DEBUG-trap equivalent)
wt_reset_color() {
  print -n '\e[0m'
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd wt_prompt_fill
add-zsh-hook preexec wt_reset_color

PROMPT="%{${WT_RESET}${WT_GRAY}%}"'${WT_FILL}'" %D{%a %b %d} %*
%{${WT_PURPLE}%}%n@%m:%{${WT_YELLOW}%}%~%{${WT_RESET}%}
%{%(?.${WT_GREEN}.${WT_RED})%}%{${WT_CYAN}%}"'$(wt_git_branch)'"%{${WT_DARK_GRAY}%}"'$(wt_git_dirty)$(wt_git_timer)'"%{${WT_WHITE}%}] %{${WT_RESET}%}"
