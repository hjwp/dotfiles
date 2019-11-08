#!/usr/bin/bash

set -ex

sudo apt install -y \
    chromium-browser \
    git \
    flatpak \
    fonts-noto-color-emoji \
    fonts-monofur \
    fonts-powerline \
    gnome-software-plugin-flatpak \
    gnome-tweak-tool \
    libpq-devel \
    vim \
    vim-gtk3 \
    oathtool \
    openvpn \
    python3-dev \
    python3-pip \
    tmux \
    tmate \
    tree \
    xclip \
    xvfb \
    zsh

# flatpak is a linux app store that has bluejeans

# use resolvconf so that made vpn worsk
sudo apt install resolvconf
sudo resolvconf --enable-updates

# docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"

# TODO: replace bionic with $(lsb_release -cs)

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd -f docker
sudo usermod -aG docker harry

# virtualenvwrapper for zsh plugin
python3 -m pip install virtualenvwrapper

