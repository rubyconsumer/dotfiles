############################################

# Modified from emilis bash prompt script

# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1

#

# Modified for Mac OS X by

# @corndogcomputer

# Modified further by

# @jangosteve

# Modified even further by

# @winstont

###########################################

function get_git_branch {
  git branch --no-color 2> /dev/null
}

# From https://gist.github.com/31631
# TODO: Look into git completion commands like __git_ps1
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1 /"
}

function parse_git_dirty {
  gitbranch=$(get_git_branch)
  [[ $gitbranch != "" ]] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

# taken from http://plasti.cx/2009/10/23/vebose-git-dirty-prompt
# origin of work http://henrik.nyh.se/2008/12/git-dirty-prompt
# Further modified by @jangosteve
function parse_git_dirty_2 {
  if [[ $(get_git_branch) != "" ]]
  then
    status=$(git status 2> /dev/null)
    ahead=`    echo -n "${status}" 2> /dev/null | grep -q "Your branch is ahead of" 2> /dev/null; echo "$?"`
    diverged=` echo -n "${status}" 2> /dev/null | grep -q "have diverged" 2> /dev/null; echo "$?"`
    committed=`echo -n "${status}" 2> /dev/null | grep -q "Changes to be committed" 2> /dev/null; echo "$?"`
    dirty=`    echo -n "${status}" 2> /dev/null | grep -q "Changes not staged for commit" 2> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep -q "Untracked files" 2> /dev/null; echo "$?"`
    newfile=`  echo -n "${status}" 2> /dev/null | grep -q "new file:" 2> /dev/null; echo "$?"`
    renamed=`  echo -n "${status}" 2> /dev/null | grep -q "renamed:" 2> /dev/null; echo "$?"`
    modified=` echo -n "${status}" 2> /dev/null | grep -q "modified:" 2> /dev/null; echo "$?"`
    deleted=`  echo -n "${status}" 2> /dev/null | grep -q "deleted:" 2> /dev/null; echo "$?"`

    bitsum=''
    bitind=''

    # Summary statuses
    if [ "${diverged}" == "0" ]; then
      bitsum="${bitsum}⎇ "
    fi
    if [ "${ahead}" == "0" ]; then
      bitsum="${bitsum}⇧ "
    fi
    if [ "${committed}" == "0" ]; then
      bitsum="${bitsum}✓ "
    fi
    if [ "${dirty}" == "0" ]; then
      bitsum="${bitsum}± "
    fi
    if [ "${untracked}" == "0" ]; then
      bitsum="${bitsum}⚐ "
    fi

    # Individual file statuses
    if [ "${modified}" == "0" ]; then
      bitind="${bitind}~ "
    fi
    if [ "${renamed}" == "0" ]; then
      bitind="${bitind}➔ "
    fi
    if [ "${newfile}" == "0" ]; then
      bitind="${bitind}+ "
    fi
    if [ "${deleted}" == "0" ]; then
      bitind="${bitind}- "
    fi

    # Status separator
    if [[ "${bitsum}" != '' && ${bitind} != '' ]]; then
      bitsum="${bitsum}( "
      bitind="${bitind})"
    fi

    if [ "${bitsum}${bitind}" != '' ]; then
      echo "${bitsum}${bitind} "
    fi
  fi
}

function git_info {
  gitbranch=$(parse_git_branch)
  [[ $gitbranch != "" ]] && echo "$gitbranch"
}

# Idea from http://blog.ubrio.us/nix/best-bash-prompt/
# Modified with help from @bigeasy
function parse_last_status {
  RET=$?; [ $RET -eq 0 ] && echo -e "$GREEN" || echo -e "$RED"
}

function prompt_command {
  # Fill with minuses
  # (this is recalculated every time the prompt is shown in function prompt_command):

  # create a $fill of all screen width minus the time string and a space:
  let fillsize=${COLUMNS}-20
  fill=""
  while [ "$fillsize" -gt "0" ]
  do
    # Fill with hyphens
    fill="-$fill"
    let fillsize=${fillsize}-1
  done

  # If this is an xterm set the title to name of dir
  case "$TERM" in
    xterm*|rxvt*)
    bname=`basename "${PWD/$HOME/~}"`
    echo -ne "\033]0;${bname}\007"
    ;;
    *)
    ;;
  esac
}

PROMPT_COMMAND=prompt_command



# GIT COMPLETION
source ~/Dropbox/wtsang/dotfiles/.bash/completion/git-completion.bash

function minutes_since_last_commit {
  now=`date +%s`
  # last_commit=`git log --pretty=format:'%at' -1`
  last_commit=`git log --pretty=format:'%ct' -1`
  seconds_since_last_commit=$((now-last_commit))
  minutes_since_last_commit=$((seconds_since_last_commit/60))
  echo $minutes_since_last_commit
}

function git_timer_prompt() {
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
    if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 40 ]; then
      local COLOR=${RED}
    elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 15 ]; then
      local COLOR=${YELLOW}
    else
      local COLOR=${GREEN}
    fi
    local SINCE_LAST_COMMIT="${COLOR} ($(minutes_since_last_commit)m)${NORMAL}"
    echo ${SINCE_LAST_COMMIT}
    #local GIT_TIMER=$(__git_ps1 "(%s|${SINCE_LAST_COMMIT})")
    #echo ${GIT_TIMER}
  fi
}



export -f get_git_branch
export -f parse_git_branch
export -f parse_git_dirty
export -f parse_git_dirty_2
export -f git_info
export -f parse_last_status

DEFAULT_COLOR="\033[0;0m"
ORANGE="\033[0;33m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
LIGHT_PURPLE="\033[1;34m"
WHITE="\033[1;37m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
BLUE="\033[0;34m"
LIGHT_GRAY="\033[0;37m"
DARK_GRAY="\033[1;30m"
GRAY="\033[0;90m"
BLACK="\033[0;30m"

reset_style='\['$DEFAULT_COLOR'\]'
status_style=$reset_style'\['$GRAY'\]'

export CLICOLOR=1
export PS1="$status_style"'$fill \d \t\n'"\[$PURPLE\]\u@\h:\[$YELLOW\]\w\[\033[00m\]\n\[\$(parse_last_status)\]\[$CYAN\]\$(git_info)\[$ORANGE\]\$(parse_git_dirty_2)\[$WHITE\]$(git_timer_prompt)] "
export SUDO_PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[0m\]'

# Reset color for command output
# (this one is invoked every time before a command is executed)
trap 'echo -ne "\033[00m"' DEBUG
