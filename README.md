# Dotfiles

Personal dotfiles to get me up and running on Linux. These dotfiles use [Ansible](https://docs.ansible.com). An ansible user will be setup after you do your first manual pull to periodically run a cron job that automatically keeps your desktop in sync with the repo. The id of the
ansible user is < 1000 so it shouldn't show up in the login screen. This
helps me keep multiple machines in sync.

## Usage

```bash
$ sudo ansible-pull -U https://github.com/eugenetriguba/dotfiles.git
```