
" ref. http://www.vim.org/scripts/script.php?script_id=2332
" ref. http://subtech.g.hatena.ne.jp/secondlife/20101012/1286886237
" ref. http://www.vim.org/scripts/script.php?script_id=2332
" pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
filetype off
" pathogen.vimによってbundle配下のpluginをpathに加える
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
" ファイルタイプ判定をon
filetype plugin on
