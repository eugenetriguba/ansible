#!/bin/bash
#
# @file Uninstaller
# @brief Uninstalls the files from bootstrap

source log.sh

rm -rf ~/.dotfiles ~/.zshrc ~/.poetry ~/.zcompdump-* 
       ~/.gitconfig ~/.zsh_history ~/Code ~/.pyenv >/dev/null 2>&1
export ZSH=""
msg_done "Uninstalled dotfiles"
msg_done "Note that the packages or repositories have not been uninstalled"
