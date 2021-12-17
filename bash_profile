export BASH_SILENCE_DEPRECATION_WARNING=1

echo "Running ~/.bash_profile"

echo "Loading ~/.bash/config"
source ~/.bash/config
echo "Loading ~/.bash/paths"
source ~/.bash/paths
echo "Loading ~/.bash/aliases"
source ~/.bash/aliases
echo "Loading ~/.bash/completions"
source ~/.bash/completions
echo "Loading ~/.bash/prompt"
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

echo "Checking homebrew bundle"
runonce update_brew 
