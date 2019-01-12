#!/bin/sh

if [ "$OSTYPE" = "cygwin" ]; then
COMMAND_LNK(){
    F=${1};shift;
    T=${1};shift;

    if [ -f $F ]; then
        echo "source $F" > $T
    else
        linkd $T $F
    fi
}
else
COMMAND_LNK(){
    F=${1};shift;
    T=${1};shift;

    ln -s $F $T
}
fi

LNK(){
    F=${1};shift;
    T=${1};shift;

    if [ ! -e ${F} ]; then
        echo "no such file $F";
        return;
    fi
    if [ -e $T ]; then
        echo "File already exists $T";
        return;
    fi

    COMMAND_LNK $F $T
    echo "created $T";
}

# Vim
T1="$HOME/.vimrc"
T2="$HOME/.gvimrc"
T3="$HOME/.vim"
F1="$HOME/rc/vimrc"
F2="$HOME/rc/gvimrc"
F3="$HOME/rc/vim"

echo "setup Vim（$T1, $T2, $T3） ok? [y/n]"
read ANSWER

if [ "${ANSWER}" = "y" ];
then
    LNK $F1 $T1
    LNK $F2 $T2
    LNK $F3 $T3
fi

# zsh
T1="$HOME/.zshrc"
F1="$HOME/rc/zshrc"
T2="$HOME/.zsh"
F2="$HOME/rc/zsh"

echo "setup zsh（$T1, $T2） ok? [y/n]"
read ANSWER

if [ "${ANSWER}" = "y" ];
then
    LNK $F1 $T1
    LNK $F2 $T2
fi

# git
T1="$HOME/.gitconfig"
T2="$HOME/.gitignore"
F1="$HOME/rc/private/gitconfig"
F2="$HOME/rc/gitignore"

echo "setup Git（$T1, $T2） ok? [y/n]"
read ANSWER

if [ "${ANSWER}" = "y" ];
then
    LNK $F1 $T1
    LNK $F2 $T2
fi

# Emacs
T1="$HOME/.emacs.d"
F1="$HOME/rc/emacs.d"

echo "setup Emacs（$T1） ok? [y/n]"
read ANSWER

if [ "${ANSWER}" = "y" ];
then
    LNK $F1 $T1
    LNK $F2 $T2
fi
