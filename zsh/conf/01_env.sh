export EDITOR=vim
export PAGER=less

# �p�X�̐ݒ�
PATH=./:$PATH
PATH=./bin/:$PATH
PATH=~/bin/:$PATH

SRC=~/rc/private/proxy/git-proxy-cmd.sh
[[ -e ${SRC} ]] && source ${SRC}
