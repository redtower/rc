" vim:set ts=8 sts=2 sw=2 tw=0:
"
" - 2ch viewer 'Chalice' /
"
" Last Change: 18-Feb-2003.
" Written By:  MURAOKA Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Chalice�̋N���m�F
if !ChaliceIsRunning()
  finish
endif

" ���ʐݒ�̓ǂݍ���
runtime! ftplugin/2ch.vim

setlocal foldcolumn=1
setlocal nonumber
setlocal shiftwidth=1

nnoremap <silent> <buffer> l		zo
nnoremap <silent> <buffer> h		zc
nnoremap <silent> <buffer> <CR>		:ChaliceOpenThread bookmark<CR>
nnoremap <silent> <buffer> <2-LeftMouse>	:ChaliceOpenThread bookmark<CR>
nnoremap <silent> <buffer> <Space>	:ChaliceCruise bookmark<CR>
nnoremap <silent> <buffer> +		:ChaliceCruise bookmark,semiauto<CR>

" 2ch_threadlist.vim�Ő������s�v�ȃ}�b�v���폜
nunmap <buffer> ~
nunmap <buffer> d
nunmap <buffer> p
nunmap <buffer> r
nunmap <buffer> <C-R>
nunmap <buffer> u
nunmap <buffer> x
nunmap <buffer> #
nunmap <buffer> =

"
" folding�ݒ�
"

" �X�N���v�gID���擾
map <SID>xx <SID>xx
let s:sid = substitute(maparg('<SID>xx'), 'xx$', '', '')
unmap <SID>xx

function! s:FoldText()
  " �J�e�S�����̃G���g��(URL)���𐔂��グ��
  let entry = 0
  let line = v:foldstart
  while line <= v:foldend
    if getline(line) !~ '^\(\s*\)' . Chalice_foldmark(0)
      let entry = entry + 1
    endif
    let line = line + 1
  endwhile

  let topline = getline(v:foldstart)
  let entry = ' (' . entry . ') '
  if topline !~ '^\s*' . Chalice_foldmark(0)
    return substitute(topline, '\s\S.*$', Chalice_foldmark(1) . '�y�����J�e�S���z' . entry, '')
  else
    return substitute(topline, '^\(\s*\)' . Chalice_foldmark(0), '\1' . Chalice_foldmark(1), '') . entry
  endif
endfunction

function! s:FoldLevel(lnum)
  let line = getline(a:lnum)
  let mx = '^\(\s*\)\(\S\).*'
  let level = strlen(substitute(line, mx, '\1', ''))
  let foldmark = substitute(line, mx, '\2', '')
  if foldmark ==# Chalice_foldmark(0)
    return '>' . (level + 1)
  else
    return level
  endif
endfunction

" ��荂�x��fold�̃e�X�g (���g�p)
function! s:FoldLevel2(lnum)
  let level = FoldLevel(a:lnum)
  if level !~ '^>'
    let nextlevel = FoldLevel(a:lnum + 1)
    return level !=# nextlevel ? '<' . level : level
  endif
  return level
endfunction

execute 'setlocal foldtext=' . s:sid .'FoldText()'
execute 'setlocal foldexpr=' . s:sid . 'FoldLevel(v:lnum)'
setlocal foldmethod=expr
