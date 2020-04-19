#!/bin/bash
#
# @file Ubuntu Setup
# @brief A bootstrap script for getting up and running on Ubuntu.
#        Intended to be run using bootstrap.py

# Unofficial strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# set -euo pipefail
# IFS=$'\n\t'
# disabled because of oh my zsh shell script
# oh-my-zsh.sh: line 3: ZSH_CACHE_DIR: unbound variable 

# This file is a WIP to convert to ansible


# name to search for => ppa
declare -A apt_repositories
apt_repositories["golang"]="ppa:longsleep/golang-backports"

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

if [[ -d ~/.dotfiles ]]; then
    msg_done "~/.dotfiles present"
else
    msg_run "Creating ~/.dotfiles, moving files in, and creating symlinks"
    mkdir -p ~/.dotfiles >/dev/null 2>&1
    cp -rT ./dotfiles/ ~/.dotfiles/ >/dev/null 2>&1

    rm -rf ~/.gitconfig
    ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
fi


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

if command -v pyenv >/dev/null 2>&1; then
    msg_done "pyenv"
else
    msg_run "Installing pyenv"
    curl https://pyenv.run >/dev/null 2>&1 | bash >/dev/null 2>&1
fi

if [[ -d ~/.dotfiles/.oh-my-zsh ]]; then
    msg_done "oh-my-zsh"
else
    msg_run "Installing oh my zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >/dev/null 2>&1
    rm -rf ~/.zshrc
    rm -rf ~/.zshrc.pre-oh-my-zsh
    rm -rf ~/.bash*
    mv ~/.oh-my-zsh ~/.dotfiles
    ln -s ~/.dotfiles/.zshrc ~/.zshrc >/dev/null 2>&1 

    # https://stackoverflow.com/questions/18620153/find-matching-text-and-replace-next-line
    # Change next line in prompt_dir() to only show current directory
    # $CURRENT_FG is being interpretted by the shell so this isn't working currently.
    # sed "/prompt_dir\(\)/{n;s/.*/  prompt_segment blue $CURRENT_FG '%c'/}" ~/.dotfiles/.oh-my-zsh/themes/agnoster.zsh-theme >/dev/null 2>&1

    source ~/.zshrc 
fi

msg_done "All ready to go! You may want to log out and back in.\n"

