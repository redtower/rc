# ログイン時にscreen起動する（MacOS,Cygwin以外）
if is_cygwin ; then
   export SHELL=/bin/zsh
fi
if ! is_darwin ; then
if ! is_cygwin ; then
if [ "$TERM" != "screen-bce" ]; then
    if type byobu > /dev/null ; then
        [ ${STY} ] || byobu -rx || byobu -D -RR
    else
        [ ${STY} ] || screen -rx || screen -D -RR
    fi
fi
fi
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
