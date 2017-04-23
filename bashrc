# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias gst='git status' # I can't live without this one.
alias ls='ls --color=auto'

# PS1
PS1='[\u@\h \W]\$ '

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/workspace/local-gopath
export PATH=$PATH:~/workspace/local-gopath/bin

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/z.sh

# Direnv
eval "$(direnv hook bash)"

# Chruby
source /usr/share/chruby/chruby.sh
chruby ruby

# Editor
export EDITOR=vim

# Missing Commands
source /usr/share/doc/pkgfile/command-not-found.bash

# Default BOSH Target
export BOSH_ENVIRONMENT=lite

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

wifi_list() {
    nmcli d wifi list
}
