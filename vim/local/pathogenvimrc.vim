
" ref. http://www.vim.org/scripts/script.php?script_id=2332
" ref. http://subtech.g.hatena.ne.jp/secondlife/20101012/1286886237
" ref. http://www.vim.org/scripts/script.php?script_id=2332
" pathogen��ftdetect�Ȃǂ�load�����邽�߂Ɉ�x�t�@�C���^�C�v�����off
filetype off
" pathogen.vim�ɂ����bundle�z����plugin��path�ɉ�����
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
" �t�@�C���^�C�v�����on
filetype plugin on
