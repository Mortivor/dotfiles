OS=""
if command -v "lsb_release" &> /dev/null
then
	OS="linux"
elif command -v "sw_vers" &> /dev/null
then
	OS="macos"
fi

################
# Bash-History #
################

## siehe auch http://www.techrepublic.com/article/linux-command-line-tips-history-and-histignore-in-bash/
## siehe auch https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps
## siehe auch https://wiki.archlinux.org/index.php/Bash

# Keine aufeinanderfolgenden Dopplungen und keine Befehle mit Leerzeichen am Anfang speichern
HISTCONTROL=ignoreboth
# An die History anhängen statt sie jedesmal zu überschreiben
shopt -s histappend
# Sofort in die History schreiben, nicht erst bei Schließen der Terminal-Session
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Länge der History setzen
HISTSIZE=6000
HISTFILESIZE=6000
# Bestimmte Befehle nicht mit speichern
HISTIGNORE=ls:ll:exit:history:top:htop:cd:vim:

########################
## Verschiedene Dinge ##
########################

if [[ $OS == "macos" ]]
then
	# Auf MacOS hab ich immer das Problem beim Hintereinander-Ausführen von Befehlen (Pipe) daß ich die "Option"-Taste nach dem Tippen des | noch solange gedrückt lasse daß das
	# folgende Leerzeichen noch mit "Option" zusammen gedrückt wird. Das resultiert in einem NSBP statt einem Leerzeichen. Beide sehen optisch wie ein Leerzeichen aus, doch
	# NBSP führt zu Fehlern im Terminal. Hier ein Bsp.:
	# [15:32:06] cl@MacBook-Pro-von-Christian:~ () $ echo "foobar" | grep f
	# foobar
	# [15:32:12] cl@MacBook-Pro-von-Christian:~ () $ echo "foobar" | grep f
	# -bash:  grep: Kommando nicht gefunden.
	# Hierdurch mappen wir das Key-Press-Event um, und statt NBSP wird wieder ein Leerzeichen geschrieben
	# Siehe https://superuser.com/questions/1647887/deal-with-nbsp-in-terminal
	bind '"\302\240":" "'
fi

# /sbin in den Systempfad mit aufnehmen damit man aus Bequemlichkeitsgründen z.B. ifconfig direkt aufrufen kann
export PATH=$PATH:/sbin:~/dotfiles/diff-so-fancy
# Das hier kommt für MacOS noch dazu, hier brauchen wir Homebrew. Gibt ja kein apt-get.
if [[ $OS == "macos" ]]
then
	export PATH=$PATH:/opt/homebrew/opt/mysql-client/bin:/opt/homebrew/bin
	export PATH=/opt/homebrew/opt/grep/libexec/gnubin:$PATH
fi
# beim "git pull" nicht immer noch eine Commit-Message eingeben müssen
export GIT_MERGE_AUTOEDIT=no
# ein etwas informativerer Prompt im Terminal-Fenster
export PS1='\[\033[1;36m\][\t] \[\033[1;32m\]\u@\h:\w\[\033[31m\] ($(git branch 2>/dev/null | cut -f2 -d\* -s | tr -d " ")) \[\033[01;34m\]$\[\033[00m\] '

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_aliases ]
then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
