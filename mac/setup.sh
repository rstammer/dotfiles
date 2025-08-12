#!/bin/sh

# After cloning the dotfiles repo to home folder,
# execute this script

echo "Creating default folders 🗂"
mkdir -p ~/projects ~/private_projects

echo "Installing Homebrew 🍺"
which -s brew
if [[ $? != 0 ]] ; then
  echo "Homebrew not found, installing…"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew found ✅"
fi

echo "Pouring together basic tools 🔧"
brew install tmux git neovim asdf

echo "Symlink important dotfiles 🔄"
dotfiles=".zshrc .gitconfig .tmux.conf"
for file in $dotfiles; do
  echo $file
  ln -s $HOME/dotfiles/mac/$file $HOME/$file
done

echo "Configuring neovim with LazyVim 📟"

mkdir -p $HOME/.config

# Remove existing nvim config if it exists
if [ -L "$HOME/.config/nvim" ] || [ -d "$HOME/.config/nvim" ]; then
  rm -rf $HOME/.config/nvim
fi

ln -s $HOME/dotfiles/mac/nvim $HOME/.config/nvim
