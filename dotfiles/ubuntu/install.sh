#!/bin/bash
#
# @file Ubuntu Setup
# @brief A bootstrap script for getting up and running on Ubuntu

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../lib/log.sh"

apt_without_output() {
    sudo apt $1 -y $2 >/dev/null 2>&1
}

msg '\n'

show_art "     .::            .::      .::    .::                 "
show_art "     .::            .::    .:    .: .::                 "
show_art "     .::   .::    .:.: .:.:.: .:    .::   .::     .:::: "
show_art " .:: .:: .::  .::   .::    .::  .:: .:: .:   .:: .::    "
show_art ".:   .::.::    .::  .::    .::  .:: .::.::::: .::  .::: "
show_art ".:   .:: .::  .::   .::    .::  .:: .::.:            .::"
show_art ".:: .::   .::       .::   .::  .::.:::  .::::   .:: .:: "

msg '\n'
msg_done 'Initializing setup.'
msg '\n'

msg_run "Updating software with apt.."
apt_without_output update
apt_without_output upgrade
apt_without_output autoremove

# Vim
if which vim >/dev/null 2>&1 && which nvim >/dev/null 2>&1; then
    msg_done "vim and neovim"
else
    msg_run "Installing vim and nvim"
    apt_without_output install "vim neovim"
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

# Oh my bash
if [[ -d ~/.oh-my-bash ]]; then
    msg_done "oh-my-bash"
else
    msg_run "Installing oh my bash"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" >/dev/null 2>&1
fi

msg_run "Removing previous .bashrc"
rm -rf ~/.bashrc
rm -rf ~/.bashrc.pre-oh-my-bash

msg_run "Creating ~/.dotfiles"
mkdir ~/.dotfiles >/dev/null 2>&1
cp ./dotfiles/aliases.sh ~/.dotfiles >/dev/null 2>&1
cp ./dotfiles/paths.sh ~/.dotfiles >/dev/null 2>&1
cp ./dotfiles/.bashrc ~/.dotfiles/.bashrc >/dev/null 2>&1
cp ./dotfiles/oh-my-bash.sh ~/.dotfiles/oh-my-bash.sh >/dev/null 2>&1

msg_run "Symbolic linking ~/.dotfiles/.bashrc to ~/.bashrc"
ln -s ~/.dotfiles/.bashrc ~/.bashrc >/dev/null 2>&1

source ~/.bashrc

git config --global user.name "Eugene Triguba"
git config --global user.email "eugenetriguba@gmail.com"
git config --global core.editor "vim"
msg_config "Configured git"

dconf write /org/gtk/settings/file-chooser/show-hidden true
msg_config "Set desktop to show hidden files"

msg_done "All ready to go!"

