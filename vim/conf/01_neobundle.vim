" NeoVundle
set nocompatible
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/$VIMFILE_DIR/bundle/neobundle.vim/
    call neobundle#begin(expand('~/$VIMFILE_DIR/bundle'))
endif

NeoBundleFetch 'Shogo/neobundle.vim'

" NERDTreeを設定
" :NERDTree
NeoBundle 'scrooloose/nerdtree'
" Unite
NeoBundle 'Shougo/unite.vim'
" カラースキーマー表示確認
" :Unite colorscheme -auto-preview
NeoBundle 'ujihisa/unite-colorscheme'

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache'
"Bundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'Shougo/neosnippet'

NeoBundle 'winmanager'
NeoBundle 'taglist.vim'
NeoBundle 'redtower/vim-browser'
NeoBundle 'redtower/vim-change-currentdir'
NeoBundle 'thinca/vim-github'
"NeoBundle 'edsono/vim-bufexplorer'
"Bundle 'gtags.vim'
NeoBundle 'svn.vim'
"Bundle 'duellj/DirDiff.vim'
NeoBundle 'Markdown'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'spolu/dwm.vim'

" Color Scheme
" jellybeans
NeoBundle 'nanotech/jellybeans.vim'
" hybrid
NeoBundle 'w0ng/vim-hybrid'
" solarized
NeoBundle 'altercation/vim-colors-solarized'
" mustang
NeoBundle 'croaker/mustang-vim'
" molokai
NeoBundle 'tomasr/molokai'

call neobundle#end()
filetype plugin indent on

NeoBundleCheck

