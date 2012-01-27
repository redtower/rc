# エイリアスの設定
if is_darwin ; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -ltr'
alias vi='vim'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias mf='mfiler2'
alias o='open'
if is_darwin ; then
   alias emacs='/usr/local/Cellar/emacs/23.2/bin/emacs -nw'
fi

# エイリアス
alias rtm="rtm.pl"

