# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias gst='git status' # I can't live without this one.
alias ls='ls --color=auto'
alias vim='nvim'

# PS1
PS1='[\u@\h \W]\$ '

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/workspace/local-gopath
export PATH=$PATH:~/workspace/local-gopath/bin

# Fasd
eval "$(fasd --init auto)"

# Direnv
eval "$(direnv hook bash)"

# Chruby
source /usr/share/chruby/chruby.sh
chruby ruby

# Editor
export EDITOR=nvim

# Missing Commands
source /usr/share/doc/pkgfile/command-not-found.bash

# Start GPG Agent and SSH_AUTH_SOCK
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Functions

## Adds remotes for each exiting PR
pullify() {
    git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'
    git fetch origin
}

## Encrypted secrets helpers
load_secrets() {
    encfs ~/.secrets/ ~/secrets/
}

unload_secrets() {
    fusermount -u ~/secrets/
}

## Wifi helpers
wifi_new_connection() {
    ssid=$1
    password=$2
    nmcli d wifi connect "$ssid" password "$password"
}

wifi_connect() {
    ssid=$1
    nmcli c up "$ssid"
}

wifi_disconnect() {
    nmcli d disconnect wlp58s0
}

wifi_list_connections() {
    nmcli c
}

wifi_remove_connection() {
  ssid=$1
  nmcli c delete "$ssid"
}

wifi_list() {
    nmcli d wifi list
}

## DB Helpers
start_mysql() {
    sudo cp -r /var/lib/mysql/. /var/lib/mysqldata
    sudo chown -R mysql:mysql /var/lib/mysqldata
    sudo systemctl start mariadb
}

start_postgres() {
    sudo systemctl start postgresql
}

## Touchscreen helpers
enable_touchscreen() {
  xinput enable "ELAN Touchscreen"
}

disable_touchscreen() {
  xinput disable "ELAN Touchscreen"
}
