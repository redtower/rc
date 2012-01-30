## ŠÂ‹«•Ï”‚Ìİ’è
export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

# ƒpƒX‚Ìİ’è
export PATH=./:$PATH
export PATH=./bin/:$PATH
export PATH=~/bin/:$PATH

if [ -f /usr/local/bin/proxy-cmd.sh ]; then
   export GIT_PROXY_COMMAND=/usr/local/bin/proxy-cmd.sh
fi