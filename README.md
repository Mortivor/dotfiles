# dotfiles

## MacOS

Hier gibt's ein paar Besonderheiten.

### Homebrew

Wir müssen hier [Homebrew](https://brew.sh/) installieren da MacOS ein paar veraltete und nicht kompatible Pakete mit sich bringt.

#### Exuberant-ctags

Die unter MacOS installierte Version der ctags funktioniert nicht mit dem Addon *tagbar*. Wir müssen also die exuberant-version installieren. `brew install ctags` ([ctags](https://formulae.brew.sh/formula/ctags)).
Deswegen auch die Pfadanpassung in der `.vimrc`.
