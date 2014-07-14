#!/bin/bash
# symbolic link .bashrc can not be relative path
SELF=$(test -L "$BASH_SOURCE" && readlink -n "$BASH_SOURCE" || echo "$BASH_SOURCE")
export BASEDIR=$(dirname $SELF)

# Git prompt components
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

grb_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${ERED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${EYELLOW}
        else
            local COLOR=${EGREEN}
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${EWHITE}"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "${EWHITE}[ ${EMAGENTA}%s${NO_COLOR}${EWHITE} | ${NO_COLOR}${SINCE_LAST_COMMIT} ]"`
        echo ${GIT_PROMPT}
    fi
}

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


for file in "$BASEDIR"/bash/{configs,exports,aliases,functions,local-$(whoami)}; do
    source $file
done

export GIT_PS1_SHOWDIRTYSTATE=1
source "$BASEDIR"/git-prompt.sh
source "$BASEDIR"/git-completion.bash

if is_in_remote; then
    PS1=$PS1_REMOTE
else
    if is_superuser; then
        PS1=$PS1_LOCAL_ROOT
    else
        PS1=$PS1_LOCAL_USER
    fi
fi
