#!/bin/bash

apt-get -y install git vim universal-ctags most neofetch libxml2-utils python3

FILES=(.bashrc .vimrc .neofetch.conf .gitconfig)
for FILE in "${FILES[@]}"; do
	if [[ -f "$HOME/$FILE" ]]; then
		mv "$HOME/$FILE" "$HOME/$FILE.bak"
	fi
	ln -s "$HOME/dotfiles/$FILE" "$HOME/$FILE"
done

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git submodule init && git submodule update
vim +PluginInstall +qall
