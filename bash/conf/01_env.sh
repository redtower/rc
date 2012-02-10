## ŠÂ‹«•Ï”‚Ìİ’è
export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

# ƒpƒX‚Ìİ’è
export PATH=./:$PATH
export PATH=./bin/:$PATH
export PATH=~/bin/:$PATH

SRC=~/rc/private/proxy/git-proxy-cmd.sh
[[ -e ${SRC} ]] && source ${SRC}
