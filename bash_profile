# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias gst='git status' # I can't live without this one.
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

# Editor
export EDITOR=nvim

# Start GPG Agent and SSH_AUTH_SOCK
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/Users/jamesmyers/.gnupg/S.gpg-agent.ssh"
fi

# Functions

pullify() {
    git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'
    git fetch origin
}
