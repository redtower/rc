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

" grep �R�}���h�̃v���O�����ݒ�i�f�t�H���g => findstr�j
"set grepprg=grep\ -n
