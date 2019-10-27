#!/bin/bash
#
# @file Installer
# @brief A file containing functions related to installing packages or extensions

install_apt_package() {
  PACKAGE_NAME=$1
  BIN_NAME=$2
  install_package apt $PACKAGE_NAME $BIN_NAME
}

install_package() {
  METHOD=$1
  PACKAGE_NAME=$2
  BIN_NAME=${3:-$PACKAGE_NAME}

  if application_is_present $BIN_NAME; then
    echo $PACKAGE_NAME is already installed.
    return 1
  fi

  if [ $METHOD = "apt" ]; then
    sudo apt --assume-yes install $PACKAGE_NAME
    return 0
  else
    echo "$1 is an invalid method to install with. Only 'apt' is supported."
    return 2
  fi
}

# @description Determines whether a given application is on the system.
#
# @arg $1 string Name of the application
#
# @exitcode 0 Application was found.
# @exitcode 1 Application was not found.
application_is_present() {
  APPLICATION_NAME=$1

  if which $APPLICATION_NAME > /dev/null; then
    return 0
  else
    return 1
  fi
}

application_is_not_present() {
  APPLICATION_NAME=$1
  return ! application_is_present $APPLICATION_NAME
}

# @description Downloads a file from a url
#
# @arg $1 string The url of the image.
# @arg $2 string The name of the image. Use a full path to download to a different location.
# 
# @exitcode 0 File has downloaded.
# @exitcode 1 No arguments were given.
download_file() {
  FILE_URL=$1
  FILENAME=$2

  if [ $# -eq 0 ]; then
    echo "No arguments supplied. Unable to download a file."
    exit 1
  fi

  # if [[ application_is_not_present wget && $OSTYPE -eq "darwin" ]]; then
  #   echo "wget not found on macOS. Installing via Brew..."
  #   brew install wget
  # fi

  wget --quiet --output-document=$FILENAME $FILE_URL
  return 0
}

install_chrome_extension() {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  mkdir -p "$preferences_dir_path"
  echo "{" >"$pref_file_path"
  echo "  \"external_update_url\": \"$upd_url\"" >>"$pref_file_path"
  echo "}" >>"$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}

# Google Chrome
if ! which "google-chrome" >/dev/null; then
  download_file https://dl-ssl.google.com/linux/linux_signing_key.pub |
    sudo apt-key add 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' |
    sudo tee /etc/apt/sources.list.d/google-chrome.list
  
  sudo apt update
  sudo apt --assume-yes install google-chrome-stable
else
  echo Chrome already installed
fi

# if which "1password" >/dev/null; then
#   echo 1password already installed
# fi

# if ! which "code" >/dev/null; then
#   wget --quiet --output-document=vscode.deb
# fi