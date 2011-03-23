# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
## 新しく作られたファイルのパーミッションは 644 
umask 022

## core ファイルは作らせない
ulimit -c 0

## 環境変数の設定

export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

# パスの設定
export PATH=./:$PATH
export PATH=./bin/:$PATH
export PATH=~/bin/:$PATH

if [ -f /usr/local/bin/proxy-cmd.sh ]; then
   export GIT_PROXY_COMMAND=/usr/local/bin/proxy-cmd.sh
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

# "!"をつかって履歴上のコマンドを実行するとき、
# 実行するまえに必ず展開結果を確認できるようにする。
shopt -s histverify
# 履歴の置換に失敗したときやり直せるようにする。
shopt -s histreedit
# 端末の画面サイズを自動認識。
shopt -s checkwinsize
# つねにパス名のテーブルをチェック
shopt -s checkhash

# i: 直前の履歴 30件を表示する。引数がある場合は過去 1000件を検索する。
# (history で履歴全部を表示させると多すぎるので)
function i {
  if [ "$1" ]; then history 1000 | grep "$@"; else history 30; fi
}
# I: 直前の履歴 30件を表示する。引数がある場合は過去のすべてを検索する。
function I {
  if [ "$1" ]; then history | grep "$@"; else history 30; fi
}

# ホスト名とユーザ名の先頭 2文字をとりだす。全部だと長いので。
#h2=`expr $HOSTNAME : '\(..\).*'`
#u2=`expr $USER : '\(..\).*'`
# 現在のホストによってプロンプトの色を変える。
if [[ "$EMACS" ]]; then
# emacs の shell モードでは制御文字を使わない簡単なプロンプト
PS1="$u2@$h2\w\$ "
else
# プロンプトの設定
if [[ "$SHELLTYPE" = session ]]; then
  # ある端末では短いプロンプトにする。
  PS1='$h2$ ';
  unset SHELLTYPE
else
  PS1="$u2@$h2\[\e[${col}m\]\w[\!]\$\[\e[m\] "
fi
# 通常のプロンプト PS1 に加えて PS0 という変数を設定する。
# (これは bash は何も関知しない、あとで述べる px というコマンドが使う)
# 通常のプロンプトでは現在のカレントディレクトリのフルパス名を
# 表示するようになっているが、これが長すぎるときに PS1 と PS0 を
# 一時的に切り換えて使う。
PS0="$u2@$h2:\[\e[${col}m\]\W[\!]\$\[\e[m\] "

# 端末の設定
eval `SHELL=sh tset -sQI`
stty dec crt erase ^H eof ^D quit ^\\ start ^- stop ^-
fi

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

set -o noclobber

export CVS_RSH="ssh"

##man() { gnudoit -q '(raise-frame (selected-frame)) (woman' \"$1\" ')' ; }

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    cygwin) color_prompt=yes;;
    screen) color_prompt=yes;;
    vt100) color_prompt=yes;;
    emacs) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\[\033[m\]@\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

cd
