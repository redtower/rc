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
