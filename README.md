# Dotfiles

![Preview](/preview.png)

Personal dotfiles to get me up and running on various operating systems.
These dotfiles use [Ansible](https://docs.ansible.com).

## Usage

```bash
$ sudo ansible-pull -U https://github.com/eugenetriguba/dotfiles.git
```

An ansible user will be setup after you do your first manual pull to 
run a cron job that automatically keeps your desktop in sync with the repo.