# dotfiles

## Installation

VIM öffnen und `:VundleInstall` eingeben. Damit werden alle in der `.vimrc` angegebenen Plugins installiert.
Die Dateien `.vimrc`, `.bashrc`, `.bash_aliases`, `.gitconfig` sowie das Verzeichnis `.vim` müssen als Symlink in ~ angelegt werden (z.B. `ln -s dotfiles/.bashrc .bashrc`).

## Linux

Natürlich muß ein `apt-get install vim git` ausgeführt werden.

### Exuberant-ctags

`apt-get install universal-ctags` (z.B. unter Debian 10) oder aber `apt-get install exuberant-ctags` (z.B. unter Debian 9).

## MacOS

Git wird normal installiert. Aber dann gibt's ein paar Besonderheiten.

### Homebrew

Wir müssen hier [Homebrew](https://brew.sh/) installieren da MacOS ein paar veraltete und nicht kompatible Pakete mit sich bringt.

#### Exuberant-ctags

Die unter MacOS installierte Version der ctags funktioniert nicht mit dem Addon *tagbar*. Wir müssen also die exuberant-version installieren. `brew install ctags` ([ctags](https://formulae.brew.sh/formula/ctags)).
Deswegen auch die Pfadanpassung in der `.vimrc`.

#### Anderes

Da MacOS eine sehr alte Version der Bash ausliefert müssen wir diese vllt. auch aktualisieren. Das kann man per Homebrew machen. Ich hab das damals mit einer Anleitung unter
[https://itnext.io/upgrading-bash-on-macos-7138bd1066ba](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba) gemacht. Da muß man aber mittlerweile einen Account erstellen um die Seite lesen zu können. Vllt. geht auch
der Artikel unter [https://informatik.hs-bremerhaven.de/flignitz/tutorial/bash/](https://informatik.hs-bremerhaven.de/flignitz/tutorial/bash/)
