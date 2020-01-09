#!/bin/bash
#
# @file macOS Setup
# @brief Sets up a macOS enviroment

source base.sh
source macOS/settings.sh

if xcode-select -p >/dev/null 2>&1; then
    msg_done "xcode command line tools"
else
    xcode-select --install
fi

if [[ -x $(command -v brew) ]]; then
    msg_done "homebrew"
else
    msg_run "homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

read -p "Would you like to run the Brewfile? [y/n]: " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]; then
	msg_run "brewfile"
	
	# cd macOS and cd .. is used here instead of $() to 
	# still have the output since it is a longer install process.
	cd macOS
	brew bundle
	cd ..
fi

if [[ -d $HOME/.dotfiles ]]; then
    msg_done "~/.dotfiles"
else
    msg_run "Creating ~/.dotfiles"
    mkdir ~/.dotfiles >/dev/null 2>&1
    cp ./dotfiles/aliases.sh ~/.dotfiles >/dev/null 2>&1
    cp ./dotfiles/exports.sh ~/.dotfiles >/dev/null 2>&1
	cp ./dotfiles/.zshrc ~/.dotfiles >/dev/null 2>&1
	
	if echo $ZSH | grep oh-my-zsh >/dev/null 2>&1; then
		msg_done "oh my zsh"
	else
		msg_run "oh my zsh"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
			"" --unattended >/dev/null 2>&1
		rm ~/.zshrc >/dev/null 2>&1
		rm ~/.zshrc.pre-oh-my-zsh >/dev/null 2>&1
	fi

    msg_run "Symbolic linking ~/.dotfiles/.zshrc to ~/.zshrc"
    ln -s ~/.dotfiles/.zshrc ~/.zshrc >/dev/null 2>&1
fi

if git config --global user.name >/dev/null 2>&1; then
    msg_done "git"
else
	rm ~/.gitconfig >/dev/null 2>&1
    cp ./dotfiles/.gitconfig ~/.dotfiles >/dev/null 2>&1
    ln -s ~/.dotfiles/.gitconfig ~/.gitconfig >/dev/null 2>&1
    msg_config "Configured git"
fi

if [[ -x $(command -v poetry) ]]; then
    msg_done "poetry"
else
    msg_run "poetry"
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python >/dev/null 2>&1
    source $HOME/.poetry/env
fi

if [[ -d $HOME/Code ]];
	msg_done "code directory"
else
	msg_run "code directory"
	mkdir ~/Code
fi

msg_done "All good to go! Try opening up a new terminal instance."
