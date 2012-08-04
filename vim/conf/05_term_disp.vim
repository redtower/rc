"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を表示 (nonumber:非表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (nolist:非表示)
set list
" どの文字でタブや改行を表示するかを設定
"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
"trailは行末スペース。
set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<
highlight SpecialKey term=underline ctermfg=darkgray guifg=darkgray
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)
colorscheme jellybeans " (Windows用gvim使用時はgvimrcを編集すること)

"シンタックスハイライトを有効にする
if has("syntax")
  syntax on
endif

"タブの左側にカーソル表示
"括弧入力時の対応する括弧を表示
set showmatch
"検索結果文字列のハイライトを有効にする
set hlsearch
"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
