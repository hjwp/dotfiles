#!/usr/bin/bash

set -ex
brew install \
    efm-langserver \
    fd \
    fnm \
    font-lekton-nerd-font \
    gh \
    git-delta \
    jq \
    neovim \
    ripgrep \
    starship \
    tmux \
    watchexec \ 

# fd=finder, goes with ripgrep

fnm install v18
fnm install v20
