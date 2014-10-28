platform=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

if [[ $platform == 'darwin' ]]; then

elif [[ $platform == 'linux' ]]; then
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

  # sudo
  alias sudo='sudo'
  alias nsudo='nocorrect sudo'

  # symlinks
  alias prune-symlinks='find -L . -type l -delete'

  # pbcopy/pbpaste
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# rmtrash
alias rm='rmtrash'
alias rmdir='rmdirtrash'

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# add custom bins
export PATH=$PATH:~/.yadr_config/bin
