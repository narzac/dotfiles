#!/bin/bash

if [ -f "${HOME}/.bashrc" ] ; then
    source "${HOME}/.bashrc"
fi

if [ -f "${DOTFILES_DIR}/bash/local-$(whoami)-profile" ] ; then
    source "${DOTFILES_DIR}/bash/local-$(whoami)-profile"
fi
