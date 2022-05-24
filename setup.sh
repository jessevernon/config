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
    sshfs \
    apt-transport-https

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

# MS SQL
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/21.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list

# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt install -y gh mssql-tools unixodbc-dev brave-browser
