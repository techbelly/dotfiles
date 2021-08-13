echo "Running ~/.profile"

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

