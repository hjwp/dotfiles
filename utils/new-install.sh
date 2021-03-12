#!/usr/bin/bash

set -ex

sudo apt install -y \
    ansible \
    amazon-ecr-credential-helper \
    ccze \
    chromium-browser \
    curl \
    dropbox \
    entr \
    git \
    git-lfs \
    gnupg-agent \
    jq \
    fonts-noto-color-emoji \
    fonts-monofur \
    fonts-powerline \
    gnome-tweak-tool \
    haskell-platform \
    haskell-stack \
    libpq-dev \
    oathtool \
    openvpn \
    python3-dev \
    python3-pip \
    python3.9 \
    python3.9-dev \
    python3.9-pip \
    ruby \
    software-properties-common
    tmux \
    tmate \
    tree \
    vim \
    vim-gtk3 \
    vlc \
    xclip \
    xvfb \
    zsh


# docker + signal
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

wget -O- https://updates.signal.org/desktop/apt/keys.asc |  sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io signal-desktop
sudo groupadd -f docker
sudo usermod -aG docker harry
#docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# virtualenvwrapper for zsh plugin
python3 -m pip install --user virtualenvwrapper awscli
