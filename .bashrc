###########################
# 1. System Konfiguration #
###########################

OS="unknown"
if command -v lsb_release >/dev/null 2>&1; then
	OS="linux"
elif command -v sw_vers >/dev/null 2>&1; then
	OS="macos"
elif [ "$(uname -s)" = "Linux" ]; then
	OS="linux"
fi

#################################
# 2. Bash-History Einstellungen #
#################################

## siehe auch http://www.techrepublic.com/article/linux-command-line-tips-history-and-histignore-in-bash/
## siehe auch https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps
## siehe auch https://wiki.archlinux.org/index.php/Bash

# Keine aufeinanderfolgenden Dopplungen und keine Befehle mit Leerzeichen am Anfang speichern
HISTCONTROL=ignoreboth
# An die History anhängen statt sie jedesmal zu überschreiben
shopt -s histappend
# Länge der History setzen
HISTSIZE=6000
HISTFILESIZE=6000
# Bestimmte Befehle nicht mit speichern
HISTIGNORE=ls:ll:exit:history:top:htop:cd:vim:
# Zeitstempel mit anzeigen
HISTTIMEFORMAT="%F %T "

###########################
## 3. $PATH Konfiguration #
###########################

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

# Funktion zum Bereinigen des PATH (Duplikate entfernen)
clean_path() {
    local old_path="$1"
    local new_path
    local -A seen

    IFS=':' read -ra paths <<< "$old_path"
    for path in "${paths[@]}"; do
        [[ -n "$path" && -z "${seen[$path]}" ]] && {
            new_path+="${new_path:+:}$path"
            seen["$path"]=1
        }
    done

    echo "$new_path"
}

# Das hier kommt für MacOS noch dazu, hier brauchen wir Homebrew. Gibt ja kein apt-get.
if [[ $OS == "macos" ]]
then
	# Homebrew Pfade (konsolidierte Verwaltung)
	homebrew_paths=(
		"/opt/homebrew/bin"
		"/opt/homebrew/sbin"
		"/opt/homebrew/opt/mysql-client/bin"
		"/opt/homebrew/opt/node@22/bin"
		"/opt/homebrew/opt/grep/libexec/gnubin"
	)

	# ctags (falls installiert - Priorität vor anderen Pfaden)
	if [ -d "/opt/homebrew/opt/universal-ctags/bin" ]; then
		homebrew_paths=("/opt/homebrew/opt/universal-ctags/bin" "${homebrew_paths[@]}")
	elif [ -d "/opt/homebrew/opt/ctags-exuberant/bin" ]; then
		homebrew_paths=("/opt/homebrew/opt/ctags-exuberant/bin" "${homebrew_paths[@]}")
	fi

	# PATH zusammenbauen und Duplikate entfernen
	printf -v new_path "%s:" "${homebrew_paths[@]}"
	export PATH=$(clean_path "${new_path%:}:$PATH")

	# uv (Python Paketmanager)
	if [ -f "$HOME/.local/bin/env" ]; then
		. "$HOME/.local/bin/env"
	fi
fi

###########################
# 4. PROMPT Konfiguration #
###########################

__update_git_prompt() {
	local branch
	branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [ -n "$branch" ]; then
		__git_ps1="($branch) "
	else
		__git_ps1=""
	fi
}

COLOR_LIGHT_CYAN='\[\033[1;36m\]'
COLOR_LIGHT_GREEN='\[\033[1;32m\]'
COLOR_LIGHT_BLUE='\[\033[01;34m\]'
COLOR_RED='\[\033[31m\]'
COLOR_RESET='\[\033[00m\]'

# PROMPT_COMMAND aktualisieren, um
# a) die History sofort zu schreiben, nicht erst wenn das Terminal geschlossen wird und
# b) den Git-Branch dynamisch zu ermitteln
PROMPT_COMMAND="history -a; __update_git_prompt; $PROMPT_COMMAND"
export PS1="${COLOR_LIGHT_CYAN}[\t] \
${COLOR_LIGHT_GREEN}\u@\h:\w \
${COLOR_RED}\${__git_ps1:-}\
${COLOR_LIGHT_BLUE}$ \
${COLOR_RESET}"

################
# 5. Sonstiges #
################

if command -v most >/dev/null 2>&1; then
	export PAGER=most
fi

############################
# 6. Einstellungen für Git #
############################

# beim "git pull" nicht immer noch eine Commit-Message eingeben müssen
export GIT_MERGE_AUTOEDIT=no

if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

###############################
# 7. Dinge speziell für Ariva #
###############################
if [ -f ~/.bash_aliases_firmenspezifisch ]
then
	. ~/.bash_aliases_firmenspezifisch
fi

################################################################################
# 8. Aus der Standard-Bash Konfiguration (dircolors, Aliases, Bash-Completion) #
################################################################################

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

#######################
# 9. Hilfs-Funktionen #
#######################

debug_bash() {
	echo "===== BASH DEBUG INFO ====="
	echo "Bash Version: $BASH_VERSION"
	echo "Current Path:"
	echo "$PATH" | tr ':' '\n' | nl
	echo "Loaded files:"
	echo "  .bashrc: $BASH_SOURCE"
	echo "Shell Options:"
	echo "  histappend: $(shopt -q histappend && echo 'ON' || echo 'OFF')"
	echo "  globstar: $(shopt -q globstar && echo 'ON' || echo 'OFF')"
	echo "  nocasematch: $(shopt -q nocasematch && echo 'ON' || echo 'OFF')"
	echo "  nullglob: $(shopt -q nullglob && echo 'ON' || echo 'OFF')"
	echo "==========================="
}

extract() {
	[ $# -eq 1 ] || { echo "usage: extract <archive>"; return 1; }
	if [ -f "$1" ]; then
		case "$1" in
			*.tar.bz2)   tar xvjf "$1"    ;;
			*.tar.gz)    tar xvzf "$1"    ;;
			*.bz2)       bunzip2 "$1"     ;;
			*.rar)       unrar x "$1"     ;;
			*.gz)        gunzip "$1"      ;;
			*.tar)       tar xvf "$1"     ;;
			*.tbz2)      tar xvjf "$1"    ;;
			*.tgz)       tar xvzf "$1"    ;;
			*.zip)       unzip "$1"       ;;
			*.Z)         uncompress "$1"  ;;
			*.7z)        7z x "$1"        ;;
			*)           echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file"
		return 1
	fi
}
