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

# Bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
mkdir ~/.dotfiles
cp ./dotfiles/aliases.sh ~/.dotfiles
echo "source ~/.dotfiles/aliases.sh" >> ~/.bashrc
source ~/.bashrc

# Python Setup
sudo apt -y install python3.8 python3-pip python-pip
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
source $HOME/.poetry/env

# Golang setup
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update && sudo apt upgrade -y
sudo apt -y install golang-go
mkdir ~/Code/golang/src
echo "GOPATH=$HOME/Code/golang" >> ~/.bashrc
go get -u rsc.io/2fa


