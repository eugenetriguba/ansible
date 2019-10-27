#!/bin/bash
#
# @file gsettings
# @brief Contains functions related to the manipulation of the gnome desktop enviroment

set_desktop_background() {
  gsettings set org.gnome.desktop.background picture-uri $1
}