"---------------------------------------------------------------------------
" GUI�ŗL�ł͂Ȃ���ʕ\���̐ݒ�:
"
" �s�ԍ���\�� (nonumber:��\��)
set number
" ���[���[��\�� (noruler:��\��)
set ruler
" �^�u����s��\�� (nolist:��\��)
set list
" �ǂ̕����Ń^�u����s��\�����邩��ݒ�
"���ꕶ��(SpecialKey)�̌����鉻�Blistchars��lcs�ł��ݒ�\�B
"trail�͍s���X�y�[�X�B
set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<
highlight SpecialKey term=underline ctermfg=darkgray guifg=darkgray
" �����s��܂�Ԃ��ĕ\�� (nowrap:�܂�Ԃ��Ȃ�)
set wrap
" ��ɃX�e�[�^�X�s��\�� (�ڍׂ�:he laststatus)
set laststatus=2
" �R�}���h���C���̍��� (Windows�pgvim�g�p����gvimrc��ҏW���邱��)
set cmdheight=2
" �R�}���h���X�e�[�^�X�s�ɕ\��
set showcmd
" �^�C�g����\��
set title
" ��ʂ����n�ɔ��ɂ��� (���s�̐擪�� " ���폜����ΗL���ɂȂ�)
"colorscheme evening " (Windows�pgvim�g�p����gvimrc��ҏW���邱��)
colorscheme jellybeans " (Windows�pgvim�g�p����gvimrc��ҏW���邱��)

"�V���^�b�N�X�n�C���C�g��L���ɂ���
if has("syntax")
  syntax on
endif

"�^�u�̍����ɃJ�[�\���\��
"���ʓ��͎��̑Ή����銇�ʂ�\��
set showmatch
"�������ʕ�����̃n�C���C�g��L���ɂ���
set hlsearch
"�X�e�[�^�X���C���ɕ����R�[�h�Ɖ��s������\������
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
