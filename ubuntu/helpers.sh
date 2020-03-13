apt_without_output() {
    sudo apt $1 -y $2 >/dev/null 2>&1
}

snap_install_without_output() {
    sudo snap install $1 >/dev/null 2>&1
}