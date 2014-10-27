#!/bin/bash

set -e
set -u

# Variables
dotfiles_dir=~/.dotfiles         # dotfiles
backup_dir=~/.dotfiles.bak       # old dotfiles backup_dir dotfiles_directory
home=~/
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
files=$(ls -A $dir/dotfiles)

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
      echo "There are conflicts in your $backup_dir, please clean/save old files."
      exit 1
    fi
    echo "Backing up $file to $backup_dir"
    mv ~/$basename $backup_dir
  fi
done

# Symlink them bad mofos
for file in $files; do
  basename=$(basename $file)
  ln -sf $dir/dotfiles/$file ~/$basename
done

echo -e "Finished without error!\n"
