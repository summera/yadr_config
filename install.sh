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
    backup_dir=~/.dotfiles.bak       # old dotfiles backup_dir dotfiles_directory
    files=$(ls -A dotfiles)

    # Create backup_dir
    mkdir -p $backup_dir

    # Backup files
    for file in $files; do
      basename=$(basename $file)
      if [ -L ~/$basename ]; then
        rm ~/$basename
      fi

      if [ -e ~/$basename ]; then
        if [ -L $backup_dir/$basename -o -e $backup_dir/$basename ]; then
          echo "\nThere are conflicts in your $backup_dir, please clean/save old files."
          exit 1
        fi
        echo "Backing up $file to $backup_dir"
        mv ~/$basename $backup_dir
      fi
    done

    # Symlink them bad mofos
    for file in $files; do
      basename=$(basename $file)
      ln -sf dotfiles/$file ~/$basename
    done

    PATH=$PATH:~/.yadr_config/bin
    ~/.yadr/bin/yadr/yadr-vim-add-plugin -u nanotech/jellybeans.vim
else
    echo "YADR config is already installed"
fi

echo "Finished without error!"
