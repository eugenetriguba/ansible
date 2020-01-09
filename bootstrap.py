#!/usr/bin/python3
"""
The entry point into the dotfiles. All bash script 'source' command paths 
are setup to be relative to the root directory of this repo.
"""
import argparse
import platform
import subprocess


def main():
    parser = argparse.ArgumentParser(description='Installer for dotfiles.', prog='dotfile bootstrapper')
    parser.add_argument(
        '-u', '--uninstall', default=False, action='store_true', help='Uninstall the dotfiles'
    )
    args = parser.parse_args()
    
    if args.uninstall:
        subprocess.call(['./uninstall.sh'])
        exit(0)
    
    system_name = platform.platform().lower()

    if 'darwin' in system_name:
        subprocess.call(['./macOS/install.sh'])
    elif 'ubuntu' in system_name or 'elementary' in system_name:
        subprocess.call(['./ubuntu/install.sh'])
    else:
        print(system_name + " is not supported.")


if __name__ == '__main__':
    main()
