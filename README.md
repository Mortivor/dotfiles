# dotfiles
My Bash and VIM configuration

# Compatability

Testet on

* Debian 11 (_Bullseye_)
* Debian 10 (_Buster_) (wrong symbol for "end of line")
* Debian 9 (_Stretch_) (_universal-ctags_ do not exist here; use _exuberant-ctags_; error in NERDTree-Git; wrong symbol for "end of line")

so far.

## Install

* _cd_ into your homedir (`~`).
* Clone this repo, _cd_ into `~/dotfiles` and execute `bash dotfiles/install.sh` or take the parts you want.
* Alter your Author-Information in `.gitconfig`.
* Reload _bashrc_: `source .bashrc`.

## Update

* Git Submodules: `git submodule init && git submodule update`
* VIM-Plugins: `vim +PluginInstall +qall` or open VIM and type `:PluginUpdate`.

## Things to look out for

* I'm using _python_ here to format JSON-Files. `install.sh` tries to install `python3`. But the function I inserted to `.bashrc` works with `python2` and `python` as well. So if your distro doesn't have `python3`, just install one of the other two.
* I'm using `universal-ctags`. That's a fork of `exuberant-ctags` (as I understand it, that's not maintained anymore). But `exuberant-ctags` works in my config too.

# VIM-Plugins

Plugins are managed by [Vundle](https://github.com/VundleVim/Vundle.vim).

Used are:

* [ale](https://github.com/dense-analysis/ale): Syntax-Checker / -Linter
* [ctrlp](https://github.com/ctrlpvim/ctrlp.vim): Fuzzy-Finder
* [fugitive](https://github.com/tpope/vim-fugitive): Execute Git commands
* [gitgutter](https://github.com/airblade/vim-gitgutter): Git-Symbols displayed per row
* [lightline-ale](https://github.com/maximbaz/lightline-ale): _Ale_ indicator for lightline
* [lightline-bufferline](https://github.com/mengelbrecht/lightline-bufferline): Show buffers
* [lightline](https://github.com/itchyny/lightline.vim): Statusline
* [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin): Git-Symbols displayed in NERDTree
* [nerdtree](https://github.com/scrooloose/nerdtree): Filetree view
* [snipmate](https://github.com/garbas/vim-snipmate): Use Snippets
* [tabular](https://github.com/godlygeek/tabular): Line up text as table
* [tagbar](https://github.com/majutsushi/tagbar): View outline of file
* [tlib\_vim](https://github.com/tomtom/tlib_vim): Needed for _snipmate_
* [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils): Needed for _snipmate_
* [vim-css-color](https://github.com/ap/vim-css-color): Colorize CSS color definitions
* [vim-javascript](https://github.com/pangloss/vim-javascript): Syntax-Highlighting for JavaScript
* [vim-json](https://github.com/elzr/vim-json): Hightlight JSON-Files
