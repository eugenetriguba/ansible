#!/bin/bash
#
# @file Ubuntu Setup
# @brief A bootstrap script for getting up and running on Ubuntu.
#        Instead to be run using bootstrap.py

# Unofficial strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

source base.sh
source helpers.sh

msg_run "Updating software with apt and getting add-apt-repository.."
run_apt update
run_apt upgrade
run_apt autoremove
run_apt install software-properties-common


# name to search for => ppa
declare -A apt_repositories
apt_repositories["golang"]="ppa:longsleep/golang-backports"

# bin name to check => install name
declare -A apt_packages
apt_packages["vim"]="vim"
apt_packages["nvim"]="neovim"
apt_packages["curl"]="curl"
apt_packages["git"]="git"
apt_packages["unzip"]="unzip"
apt_packages["make"]="build-essential"
apt_packages["npm"]="npm"
apt_packages["python3.8"]="python3.8"
apt_packages["pip3"]="python3-pip"
apt_packages["rst2man"]="python-docutils"
apt_packages["zsh"]="zsh"
apt_packages["go"]="golang-go"

# font name to search => install name
declare -A apt_fonts
apt_fonts["Powerline"]="fonts-powerline"

# bin name to check => install name
declare -A snap_packages
snap_packages["snap"]="snapd"
snap_packages["code"]="--classic code"

for i in "${!apt_repositories[@]}"; do
    if apt-cache policy | grep $i >/dev/null 2>&1; then
        sudo add-apt-repository -y "${apt_repositories[$i]}" >/dev/null 2>&1
        run_apt update
        run_apt upgrade
    fi
done

for i in "${!apt_packages[@]}"; do
    if command -v $i >/dev/null 2>&1; then
        msg_done "${apt_packages[$i]}"
    else
        msg_run "Installing ${apt_packages[$i]}"
        run_apt install "${apt_packages[$i]}"
    fi
done

for i in "${!apt_fonts[@]}"; do
    if fc-list | grep $i >/dev/null 2>&1; then
        msg_done "${apt_fonts[$i]}"
    else
        msg_run "Installing ${apt_fonts[$i]}"
        run_apt install "${apt_fonts[$i]}"
    fi
done

for i in "${!snap_packages[@]}"; do
    if command -v $i >/dev/null 2>&1; then
        msg_done "${snap_packages[$i]}"
    else
        msg_run "Installing ${snap_packages[$i]}"
        snap_install "${snap_packages[$i]}"
    fi
done


if echo $SHELL | grep "zsh" >/dev/null 2>&1; then
    msg_done "zsh is the current shell"
else
    msg_run "setting shell to zsh"
    chsh -s $(which zsh)
fi

if [[ -d ~/Code/go/src ]]; then
    msg_done "~/Code/go/src directories in place"
else
    msg_run "Creating ~/Code/go/src directories"
    mkdir -p ~/Code/go/src >/dev/null 2>&1
fi

if [[ -d ~/.poetry ]]; then
    msg_done "poetry"
else
    msg_run "Installing python poetry"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 >/dev/null 2>&1
    source $HOME/.poetry/env
fi

if [[ -d ~/.oh-my-zsh ]]; then
    msg_done "oh-my-zsh"
else
    msg_run "Installing oh my zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    msg_run "Removing previous .zshrc and any bash files"
    rm -rf ~/.zshrc
    rm -rf ~/.zshrc.pre-oh-my-zsh
    rm -rf ~/.bash*
fi

msg_run "Creating ~/.dotfiles"
rm -rf ~/.dotfiles
mkdir -p ~/.dotfiles >/dev/null 2>&1
cp -rT ./dotfiles/ ~/.dotfiles/ >/dev/null 2>&1
mv ~/.oh-my-zsh ~/.dotfiles

msg_run "Symbolic linking ~/.dotfiles/.zshrc to ~/.zshrc"
ln -s ~/.dotfiles/.zshrc ~/.zshrc >/dev/null 2>&1
source ~/.zshrc

rm -rf ~/.gitconfig
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
msg_config "Configured git"

msg_done "All ready to go!\n"

