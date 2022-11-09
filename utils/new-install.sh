#!/usr/bin/bash

set -ex

sudo apt install -y \
    ansible \
    asciidoctor \
    amazon-ecr-credential-helper \
    ccze \
    coderay \
    chromium-browser \
    curl \
    entr \
    git \
    git-lfs \
    gnupg-agent \
    jq \
    firefox-geckodriver \
    fonts-noto-color-emoji \
    fonts-monofur \
    fonts-powerline \
    gnome-tweak-tool \
    haskell-platform \
    haskell-stack \
    libpq-dev \
    oathtool \
    python3.9-full \
    python3.10-full \
    ruby \
    ruby-pygments.rb \
    software-properties-common
    tmux \
    tmate \
    tree \
    vim \
    vim-gtk3 \
    vlc \
    xclip \
    xvfb \
    zsh || true


# markdownlint
sudo gem install mdl

# external repos
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

wget -O- https://updates.signal.org/desktop/apt/keys.asc |  sudo apt-key add -
sudo add-apt-repository -y \
    "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main"

wget -O- https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub | sudo apt-key add -
sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-focal.list

sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
sudo add-apt-repository -y \
    "deb https://linux.dropbox.com/ubuntu xenial main"

sudo apt-get update
sudo apt-get install -y \
    docker-ce docker-ce-cli containerd.io \
    dropbox \
    signal-desktop \
    openvpn3

sudo groupadd -f docker
sudo usermod -aG docker harry

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# virtualenvwrapper for zsh plugin, black for vim
python3 -m pip install --user virtualenvwrapper awscli black
