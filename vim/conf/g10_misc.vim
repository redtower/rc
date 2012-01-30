"set shell=c:/cygwin/bin/bash.exe
"set shellcmdflag=--login
"
" 出来るだけ画面を広く使う
":set linespace=0 notitle
":let &go = substitute(&go, '[lLrRmT]', '', 'g')

set guioptions+=a
set guioptions-=T "ツールバーなし
set guioptions-=m "メニューバーなし
set guioptions-=r "右スクロールバーなし
set guioptions-=L "左スクロールバーなし


":cd $VIM\..\..\Documents

" vim7 内臓の grep を使う。
" http://bitmap.dyndns.org/blog/archives/001346.html
:set grepprg=internal

" grep を使いやすくする。
" http://bitmap.dyndns.org/blog/archives/001309.html
":let Grep_Path = 'c:/usr/bin/gnuwin32/grep.exe'
":let Grep_Find_Path = 'c:/usr/bin/gnuwin32/find.exe'
":let Grep_Xargs_Path = 'c:/usr/bin/gnuwin32/xargs.exe'

" yankしたテキストが無名レジスタだけでなく、*レジスタにも入るようにする。
" *レジスタにデータを入れると、クリップボードにデータが入るので、
" 他のアプリケーションで即ペーストして使用可能。
set clipboard+=unnamed

"81桁目以降を強調表示
"hi over80column guibg=dimgray
"match over80column /.\%>81v/
