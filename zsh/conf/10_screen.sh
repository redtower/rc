# ログイン時にscreen起動する（MacOS,Cygwin以外）
function goscreen() {
    if type byobu > /dev/null ; then
        [ ${STY} ] || byobu -rx || byobu -D -RR
    else
    if type screen > /dev/null ; then
        [ ${STY} ] || screen -rx || screen -D -RR
    fi
    fi
}

if is_cygwin ; then
   export SHELL=/bin/zsh
fi
if ! is_darwin ; then
if ! is_cygwin ; then
if [ "$TERM" != "screen-bce" ]; then
if [ "$TERM" != "screen" ]; then
    goscreen
fi
fi
fi
fi

# screen のタイトルに最後に実行したコマンドを表示する
if [ "$TERM" = "screen-bce" -o "$TERM" = "screen" ];
then
    screen_preexec() { # コマンドの実行前に呼び出される
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        lang=`echo $LANG | sed "s/.\+\.\(.\).\+/\1/"`
        c=$cmd[1]
        echo -n "k${PWD/$HOME/~}:$c:t($lang)\\"
    }
    screen_precmd() { # コマンドの実行後に呼び出される
        # cd コマンド実行後に screen のタイトル更新
        if [ "$c" = "cd" -o "$c" = "popd" ]; then
            echo -n "k${PWD/$HOME/~}:$c:t($lang)\\"
        fi
    }

    preexec_functions=($preexec_functions screen_preexec)
    precmd_functions=($precmd_functions screen_precmd)
fi
