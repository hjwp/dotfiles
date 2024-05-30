#!/usr/bin/bash

set -ex

brew install \
    efm-langserver \
    fnm \
    font-lekton-nerd-font \
    gh \
    git-delta \
    jq \
    tmux \
    watchexec \ 


fnm install v18
fnm install v20
