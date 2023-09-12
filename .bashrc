##################
## Bash-History ##
##################

# Keine aufeinanderfolgenden Dopplungen und keine Befehle mit Leerzeichen am Anfang speichern
HISTCONTROL=ignoreboth
# An die History anhängen statt sie jedesmal zu überschreiben
shopt -s histappend
# Sofort in die History schreiben, nicht erst bei Schließen der Terminal-Session
# Hier müssen wir aufpassen bei Wiederholungn per "!<nummer>", da sich die History "einfach ändern" kann
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Länge der History setzen
HISTSIZE=6000
HISTFILESIZE=6000
# Bestimmte Befehle nicht mit speichern
HISTIGNORE=ls:ll:exit:history:top:htop:cd:vim:

#############
## Aliases ##
#############

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


##################
## System-Infos ##
##################

if [[ ($- == *i*) ]]; then
	echo ""
	neofetch --config ~/.neofetch.conf
	echo ""
fi

###############
## Sonstiges ##
###############

# Mehr Farben im Terminal
export TERM=xterm-256color
# /sbin in den Systempfad mit aufnehmen damit man aus Bequemlichkeitsgründen z.B. ifconfig direkt aufrufen kann
export PATH=$PATH:/sbin:~/dotfiles/diff-so-fancy
# beim "git pull" nicht immer noch eine Commit-Message eingeben müssen
export GIT_MERGE_AUTOEDIT=no
# ein etwas informativerer Prompt im Terminal-Fenster
export PS1='\[\033[1;36m\][\t] \[\033[1;32m\]\u@\h:\w\[\033[31m\] ($(git branch 2>/dev/null | cut -f2 -d\* -s | tr -d " ")) \[\033[01;34m\]$\[\033[00m\] '
# Farben
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
# "most" ist der schönere Pager
export MANPAGER="/usr/bin/most -s"

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
