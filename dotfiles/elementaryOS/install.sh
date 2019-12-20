#!/bin/bash
#
# @file elementaryOS Setup
# @brief A bootstrap script for getting up and running on elementaryOS

# General Dependencies
sudo apt update && sudo apt upgrade -y && sudo apt -y autoremove
sudo apt -y install unzip vim neovim git curl

# Git setup
git config --global user.name "Eugene Triguba"
git config --global user.email "eugenetriguba@gmail.com"
git config --global core.editor "vim"

# Bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
mkdir ~/.dotfiles
cp ./dotfiles/aliases.sh ~/.dotfiles
cp ./dotfiles/paths.sh ~/.dotfiles
echo "source ~/.dotfiles/aliases.sh" >> ~/.bashrc
echo "source ~/.dotfiles/paths.sh" >> ~/.bashrc
source ~/.bashrc

# Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Python Setup
sudo apt -y install python3.8 python3-pip python-pip
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
source $HOME/.poetry/env

# Golang setup
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update && sudo apt upgrade -y
sudo apt -y install golang-go
mkdir ~/Code/go/src
source ~/.bashrc

go get -u rsc.io/2fa


