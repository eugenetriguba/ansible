#!/bin/bash
#
# @file Uninstaller
# @brief Uninstalls the files from bootstrap

source log.sh

rm -rf ~/.dotfiles ~/.zshrc ~/.poetry ~/.zcompdump-* ~/.gitconfig ~/.zsh_history
export ZSH=""
msg_done "Uninstalled dotfiles"
