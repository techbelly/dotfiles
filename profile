source ~/.bash/config
source ~/.bash/paths
source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/prompt

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/.homebrew_rc ]; then
	. ~/.homebrew_rc
fi

if [ -f ~/.rvm/scripts/rvm ]; then 
    . ~/.rvm/scripts/rvm
fi
[[ -s "/Users/ben/.rvm/scripts/rvm" ]] && source "/Users/ben/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
