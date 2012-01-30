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