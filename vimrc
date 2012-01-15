" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)

if has('win32') || has('win64')
  " Windowsの場合の処理
  :let $VIMFILE_DIR = 'vimfiles'
else
  " Windows以外の場合の処理
  :let $VIMFILE_DIR = '.vim'
endif

:let $LOCALVIM = '~/$VIMFILE_DIR/local/'

" Vundle
set rtp+=~/$VIMFILE_DIR/bundle/vundle/
call vundle#rc('~/$VIMFILE_DIR/bundle')

Bundle 'Shougo/neocomplcache'
Bundle 'winmanager'
Bundle 'taglist.vim'
Bundle 'redtower/vim-browser'
Bundle 'redtower/vim-change-currentdir'
Bundle 'thinca/vim-github'
Bundle 'edsono/vim-bufexplorer'

" 日本語関連の設定ファイル
source $LOCALVIM/lang.vim

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" 選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
" タグファイルを指定する
set tags=./tags,tags,~/.tags

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" 自動インデントの各段階に使われる空白の数
set shiftwidth=4
" タブをスペースに展開する（ソフトタブを有効） (noexpandtab:展開しない)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅
" 自動改行（70）
autocmd BufRead *.eml set tw=70

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
colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

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
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=builtin_xterm
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

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
"---------------------------------------------------------------------------

" ChangeLog関連の設定ファイル
if filereadable($HOME . '/rc/private/changelog.vim')
  source ~/rc/private/changelog.vim
endif

".vimrcを編集する
nnoremap <space>. :<C-u>tabedit $MYVIMRC<CR>
".vimrcを再読み込みする
nnoremap <space>s. :<C-u>source $MYVIMRC<CR>

" コメント用のシステム日付挿入。
source $LOCALVIM/insertcurrentdate.vim

"---------------------------------------------------------------------------
" プラグインの設定:

" YankRing.vim - http://www.vim.org/scripts/script.php?script_id=1234
"                http://nanasi.jp/articles/vim/yankring_vim.html
:set viminfo+=!

" winmanager - http://www.vim.org/scripts/script.php?script_id=95
let g:bufExplorerOpenMode=1
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitType=15

map <C-w><C-f> :FirstExplorerWindow<CR>
map <C-w><C-b> :BottomExplorerWindow<CR>
map <C-w><C-t> :WMToggle<CR>

" bufferlist.vim - http://nanasi.jp/articles/vim/bufferlist_vim.html
:map <silent> <C-T> :call BufferList()<CR>

let g:winManagerWindowLayout = 'FileExplorer|BufExplorer|TagList'

" taglist - http://www.vim.org/scripts/script.php?script_id=273
if has('win32')
  let Tlist_Ctags_Cmd="ctags.exe"
else
  let Tlist_Ctags_Cmd="ctags"
endif
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
map <silent> <leader>tl :TlistToggle<CR>

let NERDSpaceDelims = 1
let NERDShutUp = 1

set runtimepath+=~/vimfiles/chalice
set runtimepath+=~/.vim/chalice

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
