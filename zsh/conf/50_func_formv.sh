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
