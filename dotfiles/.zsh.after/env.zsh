platform=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

if [[ $platform == 'darwin' ]]; then

elif [[ $platform == 'linux' ]]; then

  # sudo
  alias sudo='sudo'
  alias nsudo='nocorrect sudo'

  # Echo urls instead of using browser
  export BROWSER='echo'

  # Tmuxifier
  export PATH="$HOME/.tmuxifier/bin:$PATH"
  eval "$(tmuxifier init -)"

  # Host
  export HOST='0.0.0.0'
fi

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if which pyenv > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init -)"
fi

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi

# rmtrash
alias rm='rmtrash'
alias rmdir='rmdirtrash'

# Jruby
export JRUBY_OPTS='--dev'

replace(){
  ag -l $1 | xargs perl -pi -E s/$1/$2/
}

# Android
export ANDROID_HOME=~/Library/Android/sdk

# vim
alias vim='nvim'
alias v='vim'

# rails
alias berc='bundle exec rails c'
alias bers='bundle exec rails s'
alias berm='bundle exec rake db:migrate'
alias beroll='bundle exec rake db:rollback'
alias berr='bundle exec rake routes'

setopt auto_cd

# nvm
export NVM_DIR="/Users/ari/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
