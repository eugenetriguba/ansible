export ZSH="$HOME/.dotfiles/.oh-my-zsh"
ZSH_THEME="agnoster"
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

source ~/.dotfiles/aliases.sh
source ~/.dotfiles/exports.sh

export DEFAULT_USER="$USER"
