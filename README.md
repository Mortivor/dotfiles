# dotfiles

Dies ist meine persönliche Sammlung von Konfigurationsdateien.

## Kompatible Systeme

Die Dateien wurden entwickelt und getestet auf:

* macOS 15.7 (Sequoia), mit Homebrew und Bash 5.3.8 als Shell
* KDE Neon
* Ubuntu (> 20.04)
* Debian (> 10)

## Zusätzliche Software

Was hier noch gebraucht wird um "alles" zu haben:

* *Git*
* *VIM*
* *Universal Ctags* oder seinen Vorgänger *Exuberant Ctags*
* [most](https://github.com/jedsoft/most).
* [lsd](https://github.com/Peltoche/lsd)
* Einen [Nerd font](https://www.nerdfonts.com/). Ich hab derzeit *CascadiaCode* und *0xProto* installiert.

Unter macOS muß zusätzlich noch über *Homebrew* installiert werden:

* *grep* (`brew install grep`)

## Installation

Da MacOS eine sehr alte Version der Bash ausliefert müssen wir diese vllt. auch aktualisieren. Das kann man per Homebrew machen. Ich hab das damals mit einer Anleitung unter
[https://itnext.io/upgrading-bash-on-macos-7138bd1066ba](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba) gemacht. Da muß man aber mittlerweile einen Account erstellen um die Seite lesen zu können. Vllt. geht auch
der Artikel unter [https://informatik.hs-bremerhaven.de/flignitz/tutorial/bash/](https://informatik.hs-bremerhaven.de/flignitz/tutorial/bash/)

Die *Ctags* sind sehr einfach per `apt` (Linux) oder `brew` (macOS) installierbar.

### Installation der dotfiles

1. Dieses Repo klonen, am besten nach `~`.
2. *diff-so-fancy* installieren: `git submodule update --init diff-so-fancy`
3. VIM öffnen und `:VundleInstall` eingeben. Damit werden alle in der `.vimrc` angegebenen Plugins installiert.
4. Symlinks anlegen:
	* `~/.vim -> dotfiles/.vim`
	* `~/.bashrc -> dotfiles/.bashrc`
	* `~./.bash_aliases -> dotfiles/.bash_aliases`
	* `~/.gitignore -> dotfiles/.gitignore`
	* `~/.vimrc -> dotfiles/.vimrc`
	* `~.gitconfig -> dotfiles/.gitconfig`

### Update der Submodules

```
$ cd ~/dotfiles
$ git submodule update --remote --recursive
```

### Erläuterungen für Plugins

#### markdown-preview

Nach der Installation mit Vundle noch ausführen: `:call mkdp#util#install()`.
