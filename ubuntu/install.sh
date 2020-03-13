#!/bin/bash
#
# @file Ubuntu Setup
# @brief A bootstrap script for getting up and running on Ubuntu

source base.sh
source ubuntu/helpers.sh

msg_run "Updating software with apt.."
apt_without_output update
apt_without_output upgrade
apt_without_output autoremove

# Snap
if which snap >/dev/null 2>&1; then
    msg_done "snap"
else
    msg_run "Installing snap"
    snap_install_without_output snapd
fi

# Vim
if which vim >/dev/null 2>&1 && which nvim >/dev/null 2>&1; then
    msg_done "vim and neovim"
else
    msg_run "Installing vim and nvim"
    apt_without_output install "vim neovim"
fi

# VS Code
if which code >/dev/null 2>&1; then
    msg_done "visual studio code"
else
    msg_run "Installing visual studio code"
    snap_install_without_output "--classic code"
fi

# Powerline
if fc-list | grep Powerline >/dev/null 2>&1; then
    msg_done "powerline fonts"
else
    msg_run "Installing powerline fonts"
    apt_without_output install fonts-powerline
fi

# Curl
if which curl >/dev/null 2>&1; then
    msg_done "curl"
else
    msg_run "Installing curl"
    apt_without_output install curl
fi

# Git
if which git >/dev/null 2>&1; then
    msg_done "git"
else
    msg_run "Installing git"
    apt_without_output install git
fi

# Unzip
if which unzip >/dev/null 2>&1; then
    msg_done "unzip"
else
    msg_run "Installing unzip"
    apt_without_output install unzip
fi

# Software Properties Common
if which add-apt-repository >/dev/null 2>&1; then
    msg_done "software-properties-common"
else
    msg_run "Installing software-properties-common"
    apt_without_output install software-properties-common
fi

if which npm >/dev/null 2>&1; then
    msg_done "npm"
else
    msg_run "Installing npm"
    apt_without_output install npm
fi

if which python3.8 >/dev/null 2>&1; then
    msg_done "python 3.8"
else
    msg_run "Installing python 3.8"
    apt_without_output install python3.8
fi

if which pip3 >/dev/null 2>&1; then
    msg_done "pip3"
else
    msg_run "Installing pip3"
    apt_without_output install python3-pip
fi

if which rst2man >/dev/null 2>&1; then
    msg_done "python docutils"
else
    msg_run "Installing python docutils"
    apt_without_output install python-docutils
fi

if [[ -d ~/.poetry ]]; then
    msg_done "poetry"
else
    msg_run "Installing poetry"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 >/dev/null 2>&1
    source $HOME/.poetry/env
fi

if which go >/dev/null 2>&1; then
    msg_done "go"
else
    msg_run "Installing go"
    sudo add-apt-repository -y ppa:longsleep/golang-backports >/dev/null 2>&1
    apt_without_output update
    apt_without_output upgrade
    apt_without_output install golang-go
    mkdir -p ~/Code/go/src >/dev/null 2>&1
fi

# Oh my zsh
if [[ -d ~/.oh-my-zsh ]]; then
    msg_done "oh-my-zsh"
else
    msg_run "Installing oh my zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

msg_run "Removing previous .zshrc and any bash files"
rm -rf ~/.zshrc
rm -rf ~/.zshrc.pre-oh-my-zsh
rm -rf ~/.bash*

msg_run "Creating ~/.dotfiles"
mkdir ~/.dotfiles >/dev/null 2>&1
cp ./dotfiles/* ~/.dotfiles/ >/dev/null 2>&1

msg_run "Symbolic linking ~/.dotfiles/.zshrc to ~/.zshrc"
ln -s ~/.dotfiles/.zshrc ~/.zshrc >/dev/null 2>&1
source ~/.zshrc

rm -rf ~/.gitconfig
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
msg_config "Configured git"

msg_done "All ready to go!\n"

