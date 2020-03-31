# Golang
export GOPATH=$HOME/Code/go
export GOBIN=$HOME/Code/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Python Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"