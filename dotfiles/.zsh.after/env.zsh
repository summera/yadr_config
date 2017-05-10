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
