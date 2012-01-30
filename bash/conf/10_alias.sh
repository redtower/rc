# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

  # enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto -F --show-control-chars'
    alias dir='dir --color=auto -F --show-control-chars'
    alias vdir='vdir --color=auto -F --show-control-chars'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias which='type -path'
alias cp='cp -i'
alias more="less '-E -P?f--More-- (%pb\%):--More--.'"

# h: csh における which と同じ。
function h { command -v $1; }

# wi: whatis の略。指定されたコマンドの実体を表示。
function wi {
case `type -t "$1"` in
 alias|function) type "$1";;
 file) `command -v "$1"`;;
 function) type "$1";;
esac
}

# 現在実行中のジョブを表示。
function j { jobs -l; }

# Wordnet を検索。
function tmp { cd ~/tmp; }