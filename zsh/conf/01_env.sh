export EDITOR=vim
export PAGER=less
export BROWSER=w3m

# パスの設定
PATH=./:$PATH
PATH=./bin/:$PATH
PATH=~/bin/:$PATH

SRC=~/rc/private/proxy/git-proxy-cmd.sh
[[ -e ${SRC} ]] && source ${SRC}
