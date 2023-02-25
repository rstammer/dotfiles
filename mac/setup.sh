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

echo "Configuring neovim 📟"

mkdir -p $HOME/.config/nvim

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s $HOME/dotfiles/mac/.config/nvim/init.vim $HOME/.config/nvim/init.vim
nvim +PlugInstall +qa
