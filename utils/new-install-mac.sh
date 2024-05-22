#!/usr/bin/bash

set -ex

brew install \
    efm-langserver \
    fnm \
    font-lekton-nerd-font \
    gh \
    git-delta \
    jq \
    watchexec \ 


fnm install v14
fnm install v18

