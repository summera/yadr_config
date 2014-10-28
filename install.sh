#!/bin/sh

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone https://github.com/skwp/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="false"
    rake install
else
    echo "YADR is already installed"
fi

if [ ! -d "$HOME/.yadr_config" ]; then
    echo "Installing YADR config for the first time"
    git clone https://github.com/ianks/yadr_config.git "$HOME/.yadr_config"
    cd "$HOME/.yadr_config"

    # Variables
    backup_dir=$HOME/.dotfiles.bak       # old dotfiles backup_dir dotfiles_directory
    files=$(ls -A $HOME/.yadr_config/dotfiles)

    # Create backup_dir
    mkdir -p $backup_dir

    # Backup files
    for file in $files; do
      basename=$(basename $file)
      if [ -L $HOME/$basename ]; then
        rm $HOME/$basename
      fi

      if [ -e $HOME/$basename ]; then
        echo "Backing up $file"
        mv $HOME/$basename $HOME/$basename.bak
      fi
    done

    # Symlink them bad mofos
    for file in $files; do
      basename=$(basename $file)
      ln -sf $HOME/.yadr_config/dotfiles/$file $HOME/$basename
    done

    $HOME/.yadr/bin/yadr/yadr-vim-add-plugin -u nanotech/jellybeans.vim
else
    echo "YADR config is already installed"
fi

echo "Finished without error!"
