#!/usr/bin/bash

set -ex

brew install \
    efm-langserver \
    fd \  # finder, goes with ripgrep
    fnm \
    font-lekton-nerd-font \
    gh \
    git-delta \
    jq \
    ripgrep \
    tmux \
    watchexec \ 


fnm install v18
fnm install v20
