## 環境変数の設定
export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

# パスの設定
export PATH=./:$PATH
export PATH=./bin/:$PATH
export PATH=~/bin/:$PATH

SRC=~/rc/private/proxy/git-proxy-cmd.sh
[[ -e ${SRC} ]] && source ${SRC}
