#!/bin/sh

# Firefox Plugin Vimperator
if [ ! -f ~/.vimperatorrc -a -f ~/rc/vimperatorrc ]; then
    ln -s ~/rc/vimperatorrc ~/.vimperatorrc
fi
if [ ! -f ~/.vimperator -a -f ~/rc/vimperator ]; then
    ln -s ~/rc/vimperator   ~/.vimperator
fi

# Vim
if [ ! -f ~/.vimrc -a -f ~/rc/vimrc ]; then
    ln -s ~/rc/vimrc    ~/.vimrc
fi
if [ ! -f ~/.gvimrc -a -f ~/rc/gvimrc ]; then
    ln -s ~/rc/gvimrc   ~/.gvimrc
fi
if [ ! -f ~/.vim -a -f ~/rc/vim ]; then
    ln -s ~/rc/vim      ~/.vim
fi

# zsh
if [ ! -f ~/.zshrc -a -f ~/rc/zshrc ]; then
    ln -s ~/rc/zshrc ~/.zshrc
fi

# git
if [ ! -f ~/.gitconfig -a -f ~/rc/private/gitconfig ]; then
    ln -s ~/rc/private/gitconfig ~/.gitconfig
fi
if [ ! -f ~/.gitignore -a -f ~/rc/gitignore ]; then
    ln -s ~/rc/gitignore ~/.gitignore
fi
