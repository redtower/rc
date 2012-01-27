# 文字コードの設定
case $TERM in
    linux) LANG=C ;;
        *) LANG=ja_JP.UTF-8 ;;
esac
case ${UID} in
	0) LANG=C ;; # root ユーザは LANG=C にする
esac
