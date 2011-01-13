"
"コメント用のシステム日付挿入。
"
function! InsertCDate(format)
  let old_lc_time = v:lc_time
  try
    exec ':silent! lang time C'
    let datetime = strftime(a:format)
    return datetime
  finally
    exec ':silent! lang time ' . old_lc_time
  endtry
endf
"YYYY-MM-DD HH:MM:SS

function! InputId()
  let id = input('ID:')
  return id
endf

inoremap <Leader>add // [ADD] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
nnoremap <Leader>add i// [ADD] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
vnoremap <Leader>add s// [ADD] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
inoremap <Leader>upd // [UPD] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
nnoremap <Leader>upd i// [UPD] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
vnoremap <Leader>upd s// [UPD] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
inoremap <Leader>del // [DEL] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
nnoremap <Leader>del i// [DEL] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>
vnoremap <Leader>del s// [DEL] <C-R>=InsertCDate('%Y-%m-%d %H:%M:%S')<CR> []<ESC>i<C-R>=InputId()<CR>

inoremap <Leader>list <list type=""></list><ESC>9h
nnoremap <Leader>list i<list type=""></list><ESC>9h
vnoremap <Leader>list s<list type=""></list><ESC>9h
inoremap <Leader>item <item></item><ESC>7h
nnoremap <Leader>item i<item></item><ESC>7h
vnoremap <Leader>item s<item></item><ESC>7h
inoremap <Leader>remarks <remarks></remarks><ESC>10h
nnoremap <Leader>remarks i<remarks></remarks><ESC>10h
vnoremap <Leader>remarks s<remarks></remarks><ESC>10h
inoremap <Leader>see <see cref=""/><ESC>3h
nnoremap <Leader>see i<see cref=""/><ESC>3h
vnoremap <Leader>see s<see cref=""/><ESC>3h
