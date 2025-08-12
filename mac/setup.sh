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
brew install git neovim zellij alacritty fzf ripgrep bat eza fd lazygit git-delta starship font-fira-code-nerd-font

echo "Symlink important dotfiles 🔄"
dotfiles=".zshrc .gitconfig"
for file in $dotfiles; do
  echo "Linking $file"
  [ -f "$HOME/$file" ] && rm "$HOME/$file"
  ln -s $HOME/dotfiles/mac/$file $HOME/$file
done

echo "Configuring neovim with LazyVim 📟"

mkdir -p $HOME/.config

# Remove existing nvim config if it exists
if [ -L "$HOME/.config/nvim" ] || [ -d "$HOME/.config/nvim" ]; then
  rm -rf $HOME/.config/nvim
fi

ln -s $HOME/dotfiles/mac/nvim $HOME/.config/nvim

echo "Setting up additional configs 🎨"

# Zellij config
if [ -L "$HOME/.config/zellij/config.kdl" ] || [ -f "$HOME/.config/zellij/config.kdl" ]; then
  rm -f $HOME/.config/zellij/config.kdl
fi
mkdir -p $HOME/.config/zellij
ln -s $HOME/dotfiles/mac/config.kdl $HOME/.config/zellij/config.kdl

# Starship config  
if [ -L "$HOME/.config/starship.toml" ] || [ -f "$HOME/.config/starship.toml" ]; then
  rm -f $HOME/.config/starship.toml
fi
ln -s $HOME/dotfiles/mac/starship.toml $HOME/.config/starship.toml

# Alacritty config
if [ -L "$HOME/.config/alacritty" ] || [ -d "$HOME/.config/alacritty" ]; then
  rm -rf $HOME/.config/alacritty  
fi
ln -s $HOME/dotfiles/mac/alacritty $HOME/.config/alacritty

echo "Configuring shell tools 🔧"

# Setup fzf shell integration
$(brew --prefix)/opt/fzf/install --all

# Configure git to use delta
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

echo "Setup complete! 🎉 Restart your terminal to see all changes."
