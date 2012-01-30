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
" 背景色を半透明に ref. http://liosk.blog103.fc2.com/blog-entry-148.html
"if has('win32')
"  autocmd guienter * set transparency=226
"endif

" シンタックス自動モードオン
syn on
