run_apt() {
    if [ $# -ge 1 ] && [ -n "$1" ]; then
        sudo apt $1 >/dev/null 2>&1
    else
        sudo apt $1 -y $2 >/dev/null 2>&1
    fi
}

snap_install() {
    sudo snap install $1 >/dev/null 2>&1
}