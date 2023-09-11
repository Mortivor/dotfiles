#!/bin/bash

apt-get -qq install git vim universal-ctags most neofetch libxml2-utils python3

FILES=(.bashrc .vimrc .neofetch.conf .gitconfig)
for FILE in "${FILES[@]}"; do
	if [[ -f "$HOME/$FILE" ]]; then
		mv "$HOME/$FILE" "$HOME/$FILE.bak"
	fi
	ln -s "$HOME/dotfiles/$FILE" "$HOME/$FILE"
done

cd "$HOME/dotfiles"
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
git submodule init && git submodule update
vim +PluginInstall +qall
echo "Install complete."
echo "The Plugin-Manager in VIM is Vundle. To update your plugins, type ':PluginUpdate' in VIM or 'vim +PluginUpdate +qall' in your terminal."
echo "Please reload .bashrc ('source .bashrc')."
