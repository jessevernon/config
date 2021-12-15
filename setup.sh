#!/bin/bash

sudo apt install -y \
    curl \
    neovim \
    git \
    python3 \
    zsh \
    remmina \
    awscli \
    python3-pip \
    libsecret-tools \
    universal-ctags \
    ripgrep \
    fzf \
    vlc \
    keepassxc \

snap install --classic slack

snap install \
    zoom-client \
    zoom-client \
    spt \
    sweethome3d-homedesign

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

pip3 install neovim-remote

git config --global core.editor 'nvr --remote-wait-silent'

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/21.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list

sudo apt update 
sudo apt install -y mssql-tools unixodbc-dev
