#!/usr/bin/python3

import subprocess
import platform


def main():
    system = platform.platform().lower()

    if system.rfind('darwin') != -1:
        subprocess.call(['./dotfiles/macOS/install.sh'])
    elif system.rfind('elementary') != -1:
        subprocess.call(['./dotfiles/elementaryOS/install.sh'])
    elif system.rfind('ubuntu') != -1:
        subprocess.call(['./dotfiles/ubuntu/install.sh'])
    else:
        print(system + " is not supported.")


if __name__ == '__main__':
    main()
