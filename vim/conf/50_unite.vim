""" unite.vim

" 入力モードで開始する
let g:unite_enable_start_insert=1
"最近開いたファイル履歴の保存数 
let g:unite_source_file_mru_limit = 50 
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される 
let g:unite_source_file_mru_filename_format = '' 

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"現在開いているファイルのディレクトリ下のファイル一覧。 
"開いていない場合はカレントディレクトリ 
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
"nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,uu :<C-u>Unite -buffer-name=files buffer file_mru bookmark file<CR>
"ブックマーク一覧 
nnoremap <silent> ,uc :<C-u>Unite bookmark<CR> 
"ブックマークに追加 
nnoremap <silent> ,ua :<C-u>UniteBookmarkAdd<CR> 
" neocomplcache
nnoremap <silent> ,us :<C-u>Unite snippet<CR> 
imap <C-s>  <Plug>(neocomplcache_start_unite_snippet)

"uniteを開いている間のキーマッピング 
autocmd FileType unite call s:unite_my_settings() 

function! s:unite_my_settings()"{{{ 
  "ESCでuniteを終了 
  nmap <buffer> <ESC> <Plug>(unite_exit) 
  "入力モードのときjjでノーマルモードに移動 
  imap <buffer> jj <Plug>(unite_insert_leave) 
  "入力モードのときctrl+wでバックスラッシュも削除 
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path) 
  "ctrl+jで縦に分割して開く 
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split') 
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split') 
  "ctrl+lで横に分割して開く 
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit') 
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit') 
  "ctrl+oでその場所に開く 
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open') 
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open') 
endfunction"}}}
