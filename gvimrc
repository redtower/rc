" vim:set ts=8 sts=2 sw=2 tw=0: (���̍s�Ɋւ��Ă�:help modeline���Q��)
"
"---------------------------------------------------------------------------
" �T�C�g���[�J���Ȑݒ�($VIM/gvimrc_local.vim)������Γǂݍ��ށB�ǂݍ��񂾌�
" �ɕϐ�g:gvimrc_local_finish�ɔ�0�Ȓl���ݒ肳��Ă����ꍇ�ɂ́A����ȏ�̐�
" ��t�@�C���̓Ǎ��𒆎~����B
if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ���[�U�D��ݒ�($HOME/.gvimrc_first.vim)������Γǂݍ��ށB�ǂݍ��񂾌�ɕ�
" ��g:gvimrc_first_finish�ɔ�0�Ȓl���ݒ肳��Ă����ꍇ�ɂ́A����ȏ�̐ݒ�
" �t�@�C���̓Ǎ��𒆎~����B
if 0 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" Bram���̒񋟂���ݒ����C���N���[�h (�ʃt�@�C��:vimrc_example.vim)�B����
" �ȑO��g:no_gvimrc_example�ɔ�0�Ȓl��ݒ肵�Ă����΃C���N���[�h���Ȃ��B
if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
  source $VIMRUNTIME/gvimrc_example.vim
endif

"---------------------------------------------------------------------------
" �J���[�ݒ�:
"colorscheme morning
colorscheme darkblue

"---------------------------------------------------------------------------
" �t�H���g�ݒ�:
"
if has('win32')
  " Windows�p
  "set gfn=Terminal:h10:cSHIFTJIS
  "set gfn=Osaka�|����:h10:cSHIFTJIS
  set gfn=M+2VM+IPAG_circle:h10:cSHIFTJIS
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " �s�Ԋu�̐ݒ�
  set linespace=1
  " �ꕔ��UCS�����̕��������v�����Č��߂�
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  " set guifont=Osaka�|����:h14
elseif has('xfontset')
  " UNIX�p (xfontset���g�p)
  set guifontset=a14,r14,k14
else
  set gfn=Monospace\ 11
endif

"---------------------------------------------------------------------------
" �E�C���h�E�Ɋւ���ݒ�:
"
" �E�C���h�E�̕�
set columns=100
" �E�C���h�E�̍���
set lines=50
" �R�}���h���C���̍���(GUI�g�p��)
set cmdheight=2
" ��ʂ����n�ɔ��ɂ��� (���s�̐擪�� " ���폜����ΗL���ɂȂ�)
"colorscheme evening " (Windows�pgvim�g�p����gvimrc��ҏW���邱��)

" �V���^�b�N�X�������[�h�I��
syn on
"---------------------------------------------------------------------------
" ���{����͂Ɋւ���ݒ�:
"
if has('multi_byte_ime') || has('xim')
  " IME ON���̃J�[�\���̐F��ݒ�(�ݒ��:��)
  highlight CursorIM guibg=Purple guifg=NONE
  " �}�����[�h�E�������[�h�ł̃f�t�H���g��IME��Ԑݒ�
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIM�̓��͊J�n�L�[��ݒ�:
    " ���L�� s-space ��Shift+Space�̈Ӗ���kinput2+canna�p�ݒ�
    "set imactivatekey=s-space
  endif
  " �}�����[�h�ł�IME��Ԃ��L�������Ȃ��ꍇ�A���s�̃R�����g������
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" �}�E�X�Ɋւ���ݒ�:
"
" ���:
" mousefocus�͊�����(���:�E�B���h�E�𕪊����Ă��郉�C���ɃJ�[�\��������
" �Ă��鎞�̋���)������̂Ńf�t�H���g�ł͐ݒ肵�Ȃ��BWindows�ł�mousehide
" ���A�}�E�X�J�[�\����Vim�̃^�C�g���o�[�ɒu�����{�����͂���ƃ`���`������
" �Ƃ������������N���B
"
" �ǂ̃��[�h�ł��}�E�X���g����悤�ɂ���
set mouse=a
" �}�E�X�̈ړ��Ńt�H�[�J�X�������I�ɐؑւ��Ȃ� (mousefocus:�ؑւ�)
set nomousefocus
" ���͎��Ƀ}�E�X�|�C���^���B�� (nomousehide:�B���Ȃ�)
set mousehide
" �r�W���A���I��(D&D��)�������I�ɃN���b�v�{�[�h�� (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" ���j���[�Ɋւ���ݒ�:
"
" ���:
" "M"�I�v�V�������w�肳�ꂽ�Ƃ��̓��j���[("m")�E�c�[���o�[("T")���ɓo�^����
" �Ȃ��̂ŁA�����I�ɂ����̗̈���폜����悤�ɂ����B����āA�f�t�H���g�̂�
" ���𖳎����ă��[�U���Ǝ��̈ꎮ��o�^�����ꍇ�ɂ́A����炪�\������Ȃ���
" ������肪��������B���������܂�Ƀ��A�ȃP�[�X�ł���ƍl������̂Ŗ�����
" ��B
"
if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif

"---------------------------------------------------------------------------
" ���̑��A���h���Ɋւ���ݒ�:
"
" ������������n�C���C�g���Ȃ�(_vimrc�ł͂Ȃ�_gvimrc�Őݒ肷��K�v������)
"set nohlsearch
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#
"---------------------------------------------------------------------------
" �f�B���N�g������Ɋւ���ݒ�:
"
"sort by "name", "time", or "size" default: "name"
:let g:netrw_sort_by = "time"
"sorting direction: "normal" or "reverse" default: "normal"
:let g:netrw_sort_direction = "reverse"

"---------------------------------------------------------------------------
" ����Ɋւ���ݒ�:
"
" ����:
" �����GUI�łȂ��Ă��ł���̂�vimrc�Őݒ肵���ق����ǂ���������Ȃ��B���̕�
" ���Windows�ł͂��Ȃ�B���B��ʓI�Ɉ���ɂ͖����A�ƌ����邱�Ƃ�����炵
" ���̂Ńf�t�H���g�t�H���g�͖����ɂ��Ă����B�S�V�b�N���g�������ꍇ�̓R�����g
" �A�E�g���Ă���printfont���Q�l�ɁB
"
" �Q�l:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" ����p�t�H���g
if has('printer')
  if has('win32')
    "set printfont=Terminal:h6:cSHIFTJIS
    set printfont=Terminal:h10:cSHIFTJIS
    "set printfont=MS_Mincho:h12:cSHIFTJIS
    "set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif
" �v�����^���[�h
"set printoptions=number:y
set printoptions=number:n

"---------------------------------------------------------------------------
" �v���O�C���̐ݒ�:

" bufferlist.vim - http://nanasi.jp/articles/vim/bufferlist_vim.html
:map <silent> <C-T> :call BufferList()<CR>

" grep �R�}���h�̃v���O�����ݒ�i�f�t�H���g => findstr�j
"set grepprg=grep\ -n

"---------------------------------------------------------------------------
" �L�[����o�^�F
:map <silent> <C-A> ggVG	# Ctrl+A ���ׂđI��
:map <silent> <C-C> "+y		# Ctrl+C �R�s�[
:map <silent> <C-X> "+x		# Ctrl+X �؂���
:map <silent> <C-V> "+P		# Ctrl+V �\��t��
:map U <C-R>				# U 	 �������̎������iRedo�j
:map <C-S> :!c:\cygwin\bin\bash.exe --login -i&<CR>

"�o�b�t�@�ړ��p�L�[�}�b�v
" F2: �O�̃o�b�t�@
" F3: ���̃o�b�t�@
" F4: �o�b�t�@�폜
map <F2> <ESC>:tabp<CR>
map <F3> <ESC>:tabn<CR>
map <F4> <ESC>:tabe 

"set shell=c:/cygwin/bin/bash.exe
"set shellcmdflag=--login
"
" �o���邾����ʂ��L���g��
":set linespace=0 notitle
":let &go = substitute(&go, '[lLrRmT]', '', 'g')

set guioptions+=a
set guioptions-=T "�c�[���o�[�Ȃ�
set guioptions-=m "���j���[�o�[�Ȃ�
set guioptions-=r "�E�X�N���[���o�[�Ȃ�
set guioptions-=L "���X�N���[���o�[�Ȃ�


":cd $VIM\..\..\Documents

" vim7 ������ grep ���g���B
" http://bitmap.dyndns.org/blog/archives/001346.html
:set grepprg=internal

" grep ���g���₷������B
" http://bitmap.dyndns.org/blog/archives/001309.html
":let Grep_Path = 'c:/usr/bin/gnuwin32/grep.exe'
":let Grep_Find_Path = 'c:/usr/bin/gnuwin32/find.exe'
":let Grep_Xargs_Path = 'c:/usr/bin/gnuwin32/xargs.exe'

" yank�����e�L�X�g���������W�X�^�����łȂ��A*���W�X�^�ɂ�����悤�ɂ���B
" *���W�X�^�Ƀf�[�^������ƁA�N���b�v�{�[�h�Ƀf�[�^������̂ŁA
" ���̃A�v���P�[�V�����ő��y�[�X�g���Ďg�p�\�B
set clipboard+=unnamed

"81���ڈȍ~�������\��
"hi over80column guibg=dimgray
"match over80column /.\%>81v/
