# MacPorts
if [ -d /opt/local ]; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi
# Local MySQL
if [ -d /usr/local/mysql/bin ]; then
  export PATH=/usr/local/mysql/bin:$PATH
fi
# Local Gems
export PATH=~/Applications/scripts:$PATH
if [ -d  ~/.gem/ruby/1.8/bin ]; then
  export PATH=~/.gem/ruby/1.8/bin:$PATH
fi
 
export SVN_EDITOR='mate -w'
export EDITOR='mate -w'

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

extract () 
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'


# Open a manpage in Preview, which can be saved to PDF
pman()
{
   man -t "${1}" | open -f -a /Applications/Preview.app
}

# http://www.macosxhints.com/article.php?story=20060502160527780&query=terminal%2Btitle
function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }
 
# Colours
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
     GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"
       GRAY="\[\033[1;30m\]"
 
# Get the current git branch, if there is one
function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}⚡"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${BLUE}↑"
    else
      remote="${BLUE}↓"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${BLUE}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}
 
function prompt_func() {
  previous_return_value=$?;
  prompt="${TITLEBAR}${GRAY}\W${BLUE}$(parse_git_branch)${COLOR_NONE}"
  if test $previous_return_value -eq 0
  then
    PS1="${GREEN}∆  ${COLOR_NONE}${prompt}${GREEN} \$${COLOR_NONE} "
  else
    PS1="${RED}∇  ${COLOR_NONE}${prompt}${RED} \$${COLOR_NONE} "
  fi
}
 
PROMPT_COMMAND=prompt_func
 
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
 
if [ -f ~/.gpg-agent-info ]; then
  source ~/.gpg-agent-info
fi
 
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
    source /opt/local/etc/bash_completion.d/git
fi
 

SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | egrep -v [0123456789]) )
complete -o default -W "${SSH_COMPLETE[*]}" ssh
