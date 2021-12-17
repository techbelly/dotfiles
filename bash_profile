echo "Running ~/.profile"

source ~/.bash/config
source ~/.bash/paths
source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/prompt

if [ -f ~/.bashrc ]; then
  echo "Running .bashrc"
  . ~/.bashrc
fi

if [ -f ~/.homebrew_rc ]; then
  echo "Running homebrew_rc"
	. ~/.homebrew_rc
fi

if [ -f ~/.rvm/scripts/rvm ]; then 
  echo "Running homebrew_rc"
    . ~/.rvm/scripts/rvm
fi

if [ -f /usr/local/opt/openjdk/bin/java ]; then
  echo "Adding openjdk java to PATH"
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi

if type brew &>/dev/null; then
  echo "Initialising homebrew bash completions" 
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

if type asdf &>/dev/null; then
  echo "Initialising asdf"
  source /usr/local/opt/asdf/asdf.sh
fi

if type brew &>/dev/null; then
  cd ~/Projects/dotfiles
  echo "Checking for outdated homebrew packages"
  brew outdated
  echo "Checking for homebrew packages not in Brewfile"
  brew bundle check
  brew bundle cleanup
  cd ~
fi
