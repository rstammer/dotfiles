echo "Symlink important dotfiles 🔄"
dotfiles=".zshrc .gitconfig .tmux.conf"
for file in $dotfiles; do
  echo $file
  ln -s $HOME/dotfiles/mac/$file $HOME/$file
done

brew install neovim

echo "Configuring neovim 📟"

mkdir -p $HOME/.config/nvim

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s $HOME/dotfiles/mac/.config/nvim/init.vim $HOME/.config/nvim/init.vim
nvim +PlugInstall +qa
