#!/bin/bash
MYUSER="narzac"
MYHOME="/Users"
export BASEDIR="$MYHOME"/"$MYUSER"/Code/dotfiles

function is_superuser() {
    if [[  "$(whoami)" == "root"  ]]; then
       export CURRENT_USER="root"
       return 0
    fi
    export CURRENT_USER="$MYUSER"
    return 1
}

function is_in_remote() {
    if [[ -z "$SSH_TTY" ]]; then
       return 1
    fi
    return 0
}

for file in "$BASEDIR"/bash/*; do
    source $file
done

if is_in_remote; then
    PS1=$PS1_REMOTE
else
    if is_superuser; then
	PS1=$PS1_LOCAL_ROOT
    else
	PS1=$PS1_LOCAL_USER
    fi
fi
