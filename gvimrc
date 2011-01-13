" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/gvimrc_local.vim)があれば読み込む。読み込んだ後
" に変数g:gvimrc_local_finishに非0な値が設定されていた場合には、それ以上の設
" 定ファイルの読込を中止する。
if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.gvimrc_first.vim)があれば読み込む。読み込んだ後に変
" 数g:gvimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_gvimrc_exampleに非0な値を設定しておけばインクルードしない。
if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
  source $VIMRUNTIME/gvimrc_example.vim
endif

"---------------------------------------------------------------------------
" カラー設定:
"colorscheme morning
colorscheme darkblue

"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  "set gfn=Terminal:h10:cSHIFTJIS
  "set gfn=Osaka－等幅:h10:cSHIFTJIS
  set gfn=M+2VM+IPAG_circle:h10:cSHIFTJIS
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  " set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
else
  set gfn=Monospace\ 11
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=100
" ウインドウの高さ
set lines=50
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

" シンタックス自動モードオン
syn on
"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" メニューに関する設定:
"
" 解説:
" "M"オプションが指定されたときはメニュー("m")・ツールバー("T")供に登録され
" ないので、自動的にそれらの領域を削除するようにした。よって、デフォルトのそ
" れらを無視してユーザが独自の一式を登録した場合には、それらが表示されないと
" いう問題が生じ得る。しかしあまりにレアなケースであると考えられるので無視す
" る。
"
if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif

"---------------------------------------------------------------------------
" その他、見栄えに関する設定:
"
" 検索文字列をハイライトしない(_vimrcではなく_gvimrcで設定する必要がある)
"set nohlsearch
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#
"---------------------------------------------------------------------------
" ディレクトリ操作に関する設定:
"
"sort by "name", "time", or "size" default: "name"
:let g:netrw_sort_by = "time"
"sorting direction: "normal" or "reverse" default: "normal"
:let g:netrw_sort_direction = "reverse"

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
if has('printer')
  if has('win32')
    "set printfont=Terminal:h6:cSHIFTJIS
    set printfont=Terminal:h10:cSHIFTJIS
    "set printfont=MS_Mincho:h12:cSHIFTJIS
    "set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif
" プリンタモード
"set printoptions=number:y
set printoptions=number:n

"---------------------------------------------------------------------------
" プラグインの設定:

" bufferlist.vim - http://nanasi.jp/articles/vim/bufferlist_vim.html
:map <silent> <C-T> :call BufferList()<CR>

" grep コマンドのプログラム設定（デフォルト => findstr）
"set grepprg=grep\ -n

"---------------------------------------------------------------------------
" キー操作登録：
:map <silent> <C-A> ggVG	# Ctrl+A すべて選択
:map <silent> <C-C> "+y		# Ctrl+C コピー
:map <silent> <C-X> "+x		# Ctrl+X 切り取り
:map <silent> <C-V> "+P		# Ctrl+V 貼り付け
:map U <C-R>				# U 	 取り消しの取り消し（Redo）
:map <C-S> :!c:\cygwin\bin\bash.exe --login -i&<CR>

"バッファ移動用キーマップ
" F2: 前のバッファ
" F3: 次のバッファ
" F4: バッファ削除
map <F2> <ESC>:tabp<CR>
map <F3> <ESC>:tabn<CR>
map <F4> <ESC>:tabe 

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
