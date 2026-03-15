#!/usr/bin/bash

set -ex
brew install \
    efm-langserver \
    fd \
    fnm \
    gh \
    git-delta \
    jq \
    neovim \
    ripgrep \
    starship \
    tmux \
    watchexec \ 

# font-lekton-nerd-font \
# fd=finder, goes with ripgrep

fnm install v18
fnm install v20
