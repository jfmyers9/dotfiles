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
pullify() {
    git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'
    git fetch origin
}

load_secrets() {
    encfs ~/.secrets/ ~/secrets/
}

unload_secrets() {
    fusermount -u ~/secrets/
}
