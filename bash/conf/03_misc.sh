# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
## 新しく作られたファイルのパーミッションは 644 
umask 022

## core ファイルは作らせない
ulimit -c 0

# 上書き禁止
set -o noclobber

export CVS_RSH="ssh"

##man() { gnudoit -q '(raise-frame (selected-frame)) (woman' \"$1\" ')' ; }

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi