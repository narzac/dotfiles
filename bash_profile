#!/bin/bash

if [ -f "${HOME}/.bashrc" ] ; then
    source "${HOME}/.bashrc"
fi

if [ -f "./bash/local-$(whoami)-profile" ] ; then
    source "./bash/local-$(whoami)-profile"
fi
