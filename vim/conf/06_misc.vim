"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" スワップファイルを作成しない
set noswapfile

"---------------------------------------------------------------------------
" キー操作登録：
:map U <C-R>			# U 	 取り消しの取り消し（Redo）

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
let g:treeExplVertical=1

".vimrcを編集する
nnoremap <space>. :<C-u>tabedit $MYVIMRC<CR>
".vimrcを再読み込みする
nnoremap <space>s. :<C-u>source $MYVIMRC<CR>

nnoremap <space>cd :cd %:h<CR>

" Leader 変更
map \ <leader>
