alias ls='ls --color=auto'
alias dmesg='sudo dmesg -HL'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lh'
alias cd..='cd ..'
alias locate='locate -i'
alias df='df -h'
alias duall='du -sh * | sort -h'
alias docker_ls_dangling='docker images --filter "dangling=true"'
alias docker_rm_dangling='docker rmi $(docker images -q --filter "dangling=true")'
alias docker_login='docker login registry-gitlab.ariva-services.de; docker login gitlab.ariva-services.de:443'
alias start_ekp='docker run -d --name ubs-easykid-pro-web -p 80:80 --platform linux/amd64 --rm \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/dev.conf:/etc/ubs-easykid-pro/config/dev.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/apache2.conf:/etc/apache2/apache2.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/envvars:/etc/apache2/envvars \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/startup.pl:/etc/apache2/startup.pl \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/conf/security.conf:/etc/apache2/conf-enabled/security.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/mods/info.conf:/etc/apache2/mods-enabled/info.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/mods/mime.conf:/etc/apache2/mods-enabled/mime.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/mods/mpm_prefork.conf:/etc/apache2/mods-enabled/mpm_prefork.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/mods/status.conf:/etc/apache2/mods-enabled/status.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab/config/apache2.4/sites/001-easykid-pro-dev.conf:/etc/apache2/sites-enabled/001-easykid-pro-dev.conf \
-v /Users/cl/git_repos/UBS\ EasyKID\ Pro/EasyKID_Pro_Gitlab:/srv/EasyKID_Pro \
ubs-easykid-pro-web:0.1'
