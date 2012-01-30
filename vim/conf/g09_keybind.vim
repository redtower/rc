"---------------------------------------------------------------------------
" キー操作登録：
:map <silent> <C-A> ggVG	# Ctrl+A すべて選択
:map <silent> <C-C> "+y		# Ctrl+C コピー
:map <silent> <C-X> "+x		# Ctrl+X 切り取り
:map <silent> <C-V> "+P		# Ctrl+V 貼り付け
:map <C-S> :!c:\cygwin\bin\bash.exe --login -i&<CR>

"バッファ移動用キーマップ
" F2: 前のバッファ
" F3: 次のバッファ
" F4: バッファ削除
map <F2> <ESC>:tabp<CR>
map <F3> <ESC>:tabn<CR>
map <F4> <ESC>:tabe 
