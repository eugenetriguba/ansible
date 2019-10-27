#!/bin/bash
#
# @file Ubuntu Setup
# @brief A bootstrap script for getting up and running on Ubuntu

. ./library/install.sh
. ./library/gsettings.sh

install_apt_package unzip
install_apt_package vim
install_apt_package git
install_apt_package python3-pip pip3
# /usr/bin/python3 -m pip install -U pylint --user

download_file \
    "https://i2.wp.com/512pixels.net/wp-content/uploads/2019/10/10-14-Mojave-16.jpg" \
    ~/Pictures/mojave-dark-background.jpg

set_desktop_background ~/Pictures/mojave-dark-background.jpg

gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM