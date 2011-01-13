# Lines configured by zsh-newuser-install
export EDITOR=vim
export PAGER=less

# Proxyの設定が必要な場合は読み込み
if [ -e ~/.zsh_proxy ]; then
    source ~/.zsh_proxy
fi

## OS judge function
## Mac OS X
function is_darwin(){
    [[ $OSTYPE == darwin* ]] && return 0
    return 1
}
## Cygwin
function is_cygwin(){
    [[ $OSTYPE == cygwin ]] && return 0
    return 1
}

# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

# ヒストリに追加する条件の設定
zshaddhistory() {
	local line=${1%%$'\n'}
	local cmd=${line%% *}

	[[ ${#line} -ge 5			# 4文字以下は追加しない
		&& ${cmd} != (l|l[sal])	# コマンドが l,ls,la,ll は追加しない
		&& ${cmd} != (c|cd)		# コマンドが c,cd は追加しない
		&& ${cmd} != (m|man)	# コマンドが m,man は追加しない
	]]
}

# キーバインド設定を読み込み
source ~/rc/bindkey

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

# # ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 文字コードの設定
case $TERM in
    linux) LANG=C ;;
        *) LANG=ja_JP.UTF-8 ;;
esac
case ${UID} in
	0) LANG=C ;; # root ユーザは LANG=C にする
esac

# パスの設定
PATH=./:$PATH
PATH=./bin/:$PATH
PATH=~/bin/:$PATH
# export MANPATH=/usr/local/man:/usr/share/man

# 色付け
autoload -Uz colors
colors

# プロンプトの設定 
PROMPT="[%{${fg[magenta]}%}%n%{${reset_color}%}@%{${fg[yellow]}%}%m%1(v|%F{green}%1v%f|)%{${fg[yellow]}%}%{${reset_color}%}]%b%(!.#.$) "

RPROMPT="[%{${fg[red]}%}%~%{${reset_color}%}]:[%{${fg_bold[blue]}%}%D %T%{${reset_color}%}]"
SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "

# 履歴ファイルに時刻を記録
setopt extended_history

# # 補完するかの質問は画面を超える時にのみに行う｡
# LISTMAX=0
#
# # 補完の利用設定
autoload -Uz compinit; compinit
#
# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# cdのタイミングで自動的にpushd
setopt auto_pushd 
#
# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 補完候補が複数ある時に、一覧表示
setopt auto_list

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# 重複したヒストリは追加しない
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
#setopt NO_list_types

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名を表示可能
# setopt print_eight_bit

# シェルのプロセスごとに履歴を共有
setopt share_history

# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ディレクトリを水色にする｡
export LS_COLORS='di=01;36:ln=01;34'

# cd をしたときにlsを実行する
#function chpwd() { pwd;ls }

# ^で､cd ..
#function cdup() {
#	echo
#	cd ..
#	zle reset-prompt
#}
#zle -N cdup
#bindkey '\^' cdup

# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd

# C-s, C-qを無効にする。
setopt NO_flow_control

# 入力したコマンドが誤っている場合に修正する。
setopt correct

# 保管候補表示時にビープ音をならなくする。
setopt nolistbeep

# 先方予測機能を有効に設定する。
#autoload predict-on; predict-on

# ログイン時にscreen起動する（MacOS,Cygwin以外）
if ! is_darwin ; then
if ! is_cygwin ; then
if [ "$TERM" != "screen-bce" ]; then
    if type byobu > /dev/null ; then
        [ ${STY} ] || byobu -rx || byobu -D -RR
    else
        [ ${STY} ] || screen
    fi
fi
fi
fi

# Oracle Instant Client 用環境変数の設定
export ORACLE_HOME=/opt/oracle/instantclient
export PATH=${PATH}:${ORACLE_HOME}
export LD_LIBRARY_PATH=${ORACLE_HOME}
export NLS_LANG=Japanese_Japan.UTF8

# vcs_infoがzsh4.3.7以上に含まれるためバージョンをチェックする。
autoload -Uz is-at-least
if is-at-least 4.3.7; then
# バージョン管理システムの情報を取得する zsh の関数
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable svn git
zstyle ':vcs_info:*' branchformat '%b:r%r'
zstyle ':vcs_info:*' formats ':(%s)%b'
zstyle ':vcs_info:*' actionformats ':(%s)%b|%a'

# Gitの作業コピーに変更があるかどうかをプロンプトに表示する。
# ref. http://d.hatena.ne.jp/mollifier/20100906/p1
#autoload -Uz is-at-least
#if is-at-least 4.3.10; then
#  zstyle ':vcs_info:git*:*' check-for-changes true
#  zstyle ':vcs_info:git*:*' stagedstr "+"
#  zstyle ':vcs_info:git*:*' unstagedstr "-"
#  zstyle ':vcs_info:git*:*' formats '(%s)%b%c%u'
#  zstyle ':vcs_info:git*:*' actionformats '(%s)%b|%a%c%u'
#fi

# バージョン管理システムの情報表示
function _update_vcs_info_msg() {
    psvar=()
    LANG=C vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info_msg
fi

# screen のタイトルに最後に実行したコマンドを表示する
if [ "$TERM" = "screen-bce" ];
then
    preexec() { # コマンドの実行前に呼び出される
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        lang=`echo $LANG | sed "s/.\+\.\(.\).\+/\1/"`
        c=$cmd[1]
        echo -n "k${PWD/$HOME/~}:$c:t($lang)\\"
    }
    precmd() { # コマンドの実行後に呼び出される
        # cd コマンド実行後に screen のタイトル更新
        if [ "$c" = "cd" ]; then
            echo -n "k${PWD/$HOME/~}:$c:t($lang)\\"
        fi
    }
fi

# エイリアス
alias rtm="rtm.pl"

if [ -e ~/perl5/perlbrew/etc/bashrc ] ; then
    source ~/perl5/perlbrew/etc/bashrc
fi

# ファイル名一括変換コマンド
function formv {
    if [ $# -lt 2 ]; then
        echo 'usage: formv s/pat1/pat2/ file ..';
    else
        s=$1; shift;
        for i in "$@";
        do
            j=`echo "$i" | sed "$s"`;
            echo "$i -> $j";
            mv -i "$i" "$j";
        done
    fi
}

# End of lines configured by zsh-newuser-install
