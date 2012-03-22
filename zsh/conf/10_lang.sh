# 文字コードの設定
case $TERM in
    linux) export LANG=C ;;
        *) export LANG=ja_JP.UTF-8 ;;
esac
case ${UID} in
	0) export LANG=C ;; # root ユーザは LANG=C にする
esac
