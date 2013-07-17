#!/bin/bash
# symbolic link .bashrc can not be relative path
SELF=$(test -L "$BASH_SOURCE" && readlink -n "$BASH_SOURCE" || echo "$BASH_SOURCE")
export BASEDIR=$(dirname $SELF)
export CURRENT_USEr=$(whoami)

function is_superuser() {
    if [[  "$(whoami)" == "root"  ]]; then
       return 0
    fi
    return 1
}

function is_in_remote() {
    if [[ -z "$SSH_TTY" ]]; then
       return 1
    fi
    return 0
}


if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


for file in "$BASEDIR"/bash/*; do
    source $file
done

export GIT_PS1_SHOWDIRTYSTATE=1
source "$BASEDIR"/git-prompt.sh


if is_in_remote; then
    PS1=$PS1_REMOTE
else
    if is_superuser; then
	PS1=$PS1_LOCAL_ROOT
    else
	PS1=$PS1_LOCAL_USER
    fi
fi
