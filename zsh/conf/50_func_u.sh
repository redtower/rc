#
# Gitリポジトリ内でトップレベルに移動する関数。
# ref. http://d.hatena.ne.jp/hitode909/20100211/1265879271
function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}
