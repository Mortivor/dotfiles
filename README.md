# dotfiles
My Bash and VIM configuration

# Compatability

Testet on Debian 11 (Bullseye) so far.

## Things to look out for

* I'm using _python_ here to format JSON-Files. `install.sh` tries to install `python3`. But the function I inserted to `.bashrc` works with `python2` and `python` as well. So if your distro doesn't have `python3`, just install one of the other two.
* I'm using `universal-ctags`. That's a fork of `exuberant-ctags` (as I understand it, that's not maintained anymore). But `exuberant-ctags` works in my config too. 
