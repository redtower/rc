" vim:set ts=8 sts=2 sw=2 tw=0 fdm=marker:
"
" chalice.vim - 2ch viewer 'Chalice' /
"
" Written By:  MURAOKA Taro <koron@tka.att.ne.jp>

scriptencoding cp932
let s:version = '1.9'

" �g����
"   chalice�f�B���N�g����'runtimepath'�ɒʂ��Ă���Vim���N������:Chalice�����s
"     :set runtimepath+=$HOME/chalice
"     :Chalice


"------------------------------------------------------------------------------
" RESOLVE DEPENDENCE {{{

" �v���O�C���̖������t���O
if exists('plugin_chalice_disable')
  finish
endif
" alice.vim�̃��[�h���m���ɂ���
if !exists('*AL_version')
  runtime! plugin/alice.vim
endif
" cacheman.vim�̃��[�h���m���Ȃ��̂ɂ���
if !exists('g:version_cacheman')
  runtime! plugin/cacheman.vim
endif
" datutil.vim�̃��[�h���m���Ȃ��̂ɂ���
if !exists('*Dat2Text')
  runtime! plugin/datutil.vim
endif
" dolib.vim�̃��[�h���m���Ȃ��̂ɂ���
if !exists('g:version_dolib')
  runtime! plugin/dolib.vim
endif

"}}}

"------------------------------------------------------------------------------
" ���[�U���ݒ�\�ȃO���[�o���ϐ� {{{

" ���[�U��/�����������̖��O�ݒ�
if !exists('g:chalice_username')
  let g:chalice_username = '����������@Vim%Chalice'
endif
if !exists('g:chalice_anonyname')
  let g:chalice_anonyname = ''
endif

" ���[���A�h���X
if !exists('g:chalice_usermail')
  let g:chalice_usermail = ''
endif

" �u�b�N�}�[�N�f�[�^�t�@�C��
if !exists('g:chalice_bookmark')
  let g:chalice_bookmark = ''
endif

" �u�b�N�}�[�N�̃o�b�N�A�b�v�쐬�Ԋu (2��, 1���Ԗ����Ȃ疳����)
if !exists('g:chalice_bookmark_backupinterval')
  let g:chalice_bookmark_backupinterval = 172800
endif

" �W�����v�����̍ő�T�C�Y
if !exists('g:chalice_jumpmax')
  let g:chalice_jumpmax = 100
endif

" �����[�h�^�C��
"   g:chalice_reloadinterval_boardlist	�ꗗ�̃����[�h�^�C��(1�T��)
"   g:chalice_reloadinterval_threadlist	�̃����[�h�^�C��(30����)
"   g:chalice_reloadinterval_thread	�X���̃����[�h�^�C��(5����/���g�p)
if !exists('g:chalice_reloadinterval_boardlist')
  let g:chalice_reloadinterval_boardlist = 604800
endif
if !exists('g:chalice_reloadinterval_threadlist')
  let g:chalice_reloadinterval_threadlist = 1800
endif
"   g:chalice_reloadinterval_thread	�X���̃����[�h�^�C��(5����/���g�p)
if !exists('g:chalice_reloadinterval_thread')
  let g:chalice_reloadinterval_thread = 300
endif

" �X���N�x
"   �X��dat�̍ŏI�X�V����ݒ肳�ꂽ����(2����)���o�߂�������񎦂���B
"   g:chalice_threadinfo		�N�x�\���̗L��/�����t���O
"   g:chalice_threadinfo_expire		�N�x�ێ�����(1����)
if !exists('g:chalice_threadinfo')
  let g:chalice_threadinfo = 1
endif
if !exists('g:chalice_threadinfo_expire')
  let g:chalice_threadinfo_expire = 3600
endif

" �}���`���[�U�ݒ�
if !exists('g:chalice_multiuser')
  let g:chalice_multiuser = has('unix') && !has('macunix') ? 1 : 0
endif

" �O���u���E�U�̎w��
if !exists('g:chalice_exbrowser')
  let g:chalice_exbrowser = ''
endif

" ���[�U�t�@�C���̈ʒu�ݒ�
if !exists('g:chalice_basedir')
  if g:chalice_multiuser
    if has('win32')
      let g:chalice_basedir = $HOME . '/vimfiles/chalice'
    else
      let g:chalice_basedir = $HOME . '/.vim/chalice'
    endif
  else
    let g:chalice_basedir = substitute(expand('<sfile>:p:h'), '[/\\]plugin$', '', '')
  endif
endif

if !exists('g:chalice_menu_url')
  let g:chalice_menu_url = ''
endif

" PROXY�Ƃ�����������Ɨǂ�����
if !exists('g:chalice_curl_options')
  let g:chalice_curl_options= ''
endif

" �������ݎ��ɓ���Ȑݒ���������ꍇ
if !exists('g:chalice_curl_writeoptions')
  let g:chalice_curl_writeoptions= ''
endif

" Cookie�g��?
if !exists('g:chalice_curl_cookies')
  let g:chalice_curl_cookies = 1
endif

" gzip���k�g�p�t���O
if !exists('g:chalice_gzip')
  let g:chalice_gzip = 1
endif

" 0�ȏ�ɐݒ肷��ƃf�o�b�O�p�Ƀ��b�Z�[�W�����߂ɓ����Ă�
if !exists('g:chalice_verbose')
  let g:chalice_verbose = 0
endif

" Chalice �N������'columns'��ς��邱�Ƃ��ł���(-1:����)
if !exists('g:chalice_columns')
  let g:chalice_columns = -1
endif

" �ꗗ�̃f�t�H���g����ݒ肷��
if !exists('g:chalice_boardlist_columns')
  let g:chalice_boardlist_columns = 15
endif

" �X���ꗗ�̃f�t�H���g����ݒ肷��
if !exists('g:chalice_threadlist_lines')
  let g:chalice_threadlist_lines = 10
endif

" �ꗗ�ƞx��fold�Ɏg�p����L�����w�肷��
if !exists('g:chalice_foldmarks')
  let g:chalice_foldmarks = ''
endif

" �X�e�[�^�X���C���ɍ��ڂ�ǉ����邽�߂̕ϐ�
if !exists('g:chalice_statusline')
  let g:chalice_statusline = ''
endif

" (��0�̎�)'q'�ɂ��Chalice�I�����Ɉӎv�m�F�����Ȃ�
if !exists('g:chalice_noquery_quit')
  let g:chalice_noquery_quit = 1
endif

" (��0�̎�)�J�L�R���s�̈ӎv�m�F�����Ȃ�
if !exists('g:chalice_noquery_write')
  let g:chalice_noquery_write = 0
endif

" �N�����̏�Ԃ�ݒ肷��(bookmark,offline,nohelp,aa=[no|noanime],novercheck)
if !exists('g:chalice_startupflags')
  let g:chalice_startupflags = ''
endif

" (��0�̎�)�I�[�g�v���r���[�@�\���g�p����
if !exists('g:chalice_preview')
  let g:chalice_preview = 1
endif

" ���쎞�̊e��ݒ�(1, above, autoclose, stay)
if !exists('g:chalice_previewflags')
  let g:chalice_previewflags = ''
endif

" redraw! �ɂ��ĕ`���}������(�x���[������)
if !exists('g:chalice_noredraw')
  let g:chalice_noredraw = 0
endif

" �����ݎ��Ɏ��̎Q�Ƃ֕ύX���镶�����w��(amp,nbsp2)
if !exists('g:chalice_writeoptions')
  let g:chalice_writeoptions = 'amp,nbsp2'
endif

" �ǂݍ��ݎ��̓���Ɋւ���I�v�V����(noenc)
if !exists('g:chalice_readoptions')
  let g:chalice_readoptions = ''
endif

" �X���ꗗ�\�����ɍX�V�`�F�b�N�����邩�ǂ������w��(0: �`�F�b�N���Ȃ�)
if !exists('g:chalice_autonumcheck')
  let g:chalice_autonumcheck = 0
endif

" �A�j���[�V�������̃E�F�C�g�B�œK�Ȓl��CPU��\�����u�Ɉˑ�
if !exists('g:chalice_animewait')
  let g:chalice_animewait = 200
endif

" �U���^�C�g��(���d�����Ɏg���܂��傤)
if !exists('g:chalice_titlestring')
  let g:chalice_titlestring = ''
endif

" NG���[�h�̎w��p�^�[��("\<NL>"��؂�ŕ����̃p�^�[�����w��\)
if !exists('g:chalice_ngwords')
  let g:chalice_ngwords = ''
endif

" NG���[�h�K�p���̕\�����x��
if !exists('g:chalice_localabone')
  let g:chalice_localabone = '���[�J�����ځ[��'
endif

" 2ch�F�ؗpID
if !exists('g:chalice_loginid')
  let g:chalice_loginid = ''
endif

" 2ch�F�ؗpID
if !exists('g:chalice_password')
  let g:chalice_password = ''
endif

" �t�H�[�}�b�g�L���b�V���̗L������
if !exists('g:chalice_formatedcache_expire') || g:chalice_formatedcache_expire + 0 < 1
  let g:chalice_formatedcache_expire = 14
endif

" ����̒�~�J�e�S����
if !exists('g:chalice_cruise_endmark')
  let g:chalice_cruise_endmark = '�I��'
endif

"}}}

"------------------------------------------------------------------------------
" ���萔�l {{{
"   �����̓O���[�o���I�v�V�������ł������Ȃ́B�������̓��[�U�����������Ă���
"   �������Ȃ́B

let s:prefix_board = '  �X���ꗗ '
let s:prefix_thread = '  �X���b�h '
let s:prefix_write = '  �����X�� '
let s:prefix_preview = '  �v���r���[ '
let s:label_vimtitle = 'Chalice �`2�����˂�{���v���O�C���`'
let s:label_boardlist = '�ꗗ'
let s:label_newthread = '[�V�X��]'
let s:label_bookmark = '  �X���̞x'
let s:label_offlinemode = '�I�t���C�����[�h'
let s:label_wastetime = '���p����'
let s:label_wastetime_sum = '���ʎ��ԍ��v'
let s:label_board = '[��]'
let s:label_board_escaped = escape(s:label_board, '[]')
let s:label_localabone = 'Chalice,aboned,���[�J�����ځ[��'
" ���b�Z�[�W
let s:choice_yn = "&Yes\n&No"
let s:choice_ync = "&Yes\n&No\n&Cancel"
let s:choice_rac = "&Replace\n&Append\n&Cancel"
let s:msg_confirm_appendwrite_yn = '�o�b�t�@�̓��e���������݉\�ł�. �������݂܂���?'
let s:msg_confirm_appendwrite_ync = '�{���ɏ������݂܂���?'
let s:msg_confirm_replacebookmark = '�K�C�V���cURL�ł�. �u�������܂���?'
let s:msg_confirm_quit = '�{����Chalice���I�����܂���?'
let s:msg_prompt_articlenumber = '���ԁA�����Ă悵? '
let s:msg_warn_preview_on = '�v���r���[�@�\��L�������܂���'
let s:msg_warn_preview_off = '�v���r���[�@�\���������܂���'
let s:msg_warn_netline_on = '�I�t���C�����[�h���������܂���'
let s:msg_warn_netline_off = '�I�t���C�����[�h�ɐؑւ��܂���'
let s:msg_warn_oldthreadlist = '�X���ꗗ���Â��\��������܂�. R �ōX�V���܂�.'
let s:msg_warn_bookmark = '�x�͕��鎞�Ɏ����I�ɕۑ�����܂�.'
let s:msg_warn_bmkcancel = '�x�ւ̓o�^�̓L�����Z������܂���.'
let s:msg_warn_dontusetoomuch = '���p���߂��ɒ��ӃV��!!'
let s:msg_warn_datdirtoolsuccess = 'DATDIR�`���ւ̈ڍs���������܂���.'
let s:msg_warn_boardmoved = '���ړ������\��������܂�.'
let s:msg_wait_threadformat = '�M�l��!! �X���b�h���`���̂��߁A���΂炭���҂���������...'
let s:msg_wait_download = '�_�E�����[�h��...'
let s:msg_wait_login = '���O�C����...'
let s:msg_error_nocurl = 'Chalice�ɂ͐������C���X�g�[�����ꂽcURL���K�v�ł�.'
let s:msg_error_nogzip = 'Chalice�ɂ͐������C���X�g�[�����ꂽgzip���K�v�ł�.'
let s:msg_error_noconv = 'Chalice���CP932���ŗ��p����ɂ� qkc �������� nkf ���K�v�ł�.'
let s:msg_error_cantjump = '�J�[�\���̍s�ɃA���J�[�͂���܂���. �E��'
let s:msg_error_invalidanchor = '�A���J�[�������ł�. �T��'
let s:msg_error_cantpreview = 'DAT�����[�J���ɂȂ��̂Ńv���r���[�ł��܂���.'
let s:msg_error_appendnothread = '�S���@!! �X���b�h���Ȃ�YO!!'
let s:msg_error_creatnoboard = '���w�肵�Ȃ��ƕ��X������������܂���'
let s:msg_error_writebufhead = '�������݃o�b�t�@�̃w�b�_���s���ł�.'
let s:msg_error_writebufbody = '�������݃��b�Z�[�W����ł�.'
let s:msg_error_writeabort = '�������݂𒆎~���܂���.'
let s:msg_error_writecancel = '�������݂��L�����Z�����܂�.'
let s:msg_error_writetitle = '�V�X���ɂ̓^�C�g�����K�v�ł�.'
let s:msg_error_writecookie = '�����������Ƃ��Ă���f���̓��e�K���S�ď�������ꍇ�ɂ̂݁A���e���m�F���čēx�������ݒ����Ă�������. �������݂��s�����ꍇ�́A�����I�ɂ����̋K��ɏ]�����̂ƌ��􂳂�܂�.'
let s:msg_error_writeerror = '�������݃G���[�ł�.'
let s:msg_error_writefalse = '�������߂��悤�ł������ӂ�����܂�.'
let s:msg_error_writecheck = '�������߂��悤�ł����x��������܂�.'
let s:msg_error_writehighload = '�T�[�o�ߕ��ׂ̂��ߏ������݂ł��܂���.'
let s:msg_error_writenottrue = '�s���ȏ������݃G���[�ł�.'
let s:msg_error_addnoboardlist = '�ꗗ����x�֓o�^�o���܂���.'
let s:msg_error_addnothread = '�܂��X�����J���Ă��Ȃ��̂œo�^�o���܂���.'
let s:msg_error_addnothreadlist = '�X���ꗗ����x�֓o�^�o���܂���.'
let s:msg_error_nocachedir = '�L���b�V���f�B���N�g�����쐬�o���܂���.'
let s:msg_error_nothread = '�X���b�h�����݂��Ȃ���, �q�ɓ���(HTML��)�҂��ł�.'
let s:msg_error_accesshere = '�ڍׂ͉��LURL�ɊO���u���E�U�ŃA�N�Z�X���Ă݂Ă�������.'
let s:msg_error_newversion = 'Chalice�̐V�����o�[�W�����E�p�b�`�������[�X����Ă��܂�.'
let s:msg_error_doupdate = 'Subversion�ł𗘗p���Ă���ꍇ��svn update�ōŐV�ł����ł��܂�.'
let s:msg_error_htmlnotopen = '�X���b�h���J����Ă��܂���.'
let s:msg_error_htmlnodat = '�X���b�h��dat������܂���.'
let s:msg_error_nodatdirtool = 'DATDIR�ւ̈ڍs�c�[����������܂���. �m�F���Ă�������.'
let s:msg_error_datdirtoolfailed = 'DATDIR�ڍs�c�[�������s���܂���. �Ȃ�ł���?'
let s:msg_thread_hasnewarticles = '�V�����������݂�����܂�.'
let s:msg_thread_nonewarticle = '�V���ȏ������݂͂���܂���'
let s:msg_thread_nonewwait = '���b��ɏ���𑱍s���܂�. (CTRL-C�Ŋ����I��)'
let s:msg_thread_dead = '�q�ɂɗ�������HTML���҂��ƃI������.'
let s:msg_thread_lost = '�q�ɂɗ����܂���.'
let s:msg_thread_unknown = '���߂Č���X���ł�. �X�V�`�F�b�N�͂ł��܂���.'
let s:msg_chalice_quit = 'Chalice �`�`�`�`�I���`�`�`�`'
let s:msg_chalice_start = 'Chalice �L�m�[��'
" 1�s�w���v
let s:msg_help_boardlist = '(�ꗗ)  <CR>:����  j/k:�I��  h/l:�J�e�S����/�J  R:�X�V'
let s:msg_help_threadlist = '(�X���ꗗ)  <CR>:�X������ j/k:�X���I��  d:dat�폜  R:�X�V'
let s:msg_help_thread = '(�X���b�h)  i:����  I:sage����  a:��������  A:����sage  r:�X�V =:���`'
let s:msg_help_bookmark = '(�X���̞x)  <CR>:URL����  h/l:��/�J <C-A>:����  [�ҏW�\]'
let s:msg_help_write = '(��������)  <C-CR>:�������ݎ��s  <C-W>c:����  [�ҏW�\]'
let s:msg_help_rewrite = '�������݂Ɏ��s�����Ǝv���镶�͂𕜋A���܂���.'
"}}}

"------------------------------------------------------------------------------
" �萔�l CONSTANT {{{
"   �����ł̂ݎg�p�������

" �f�o�b�O�t���O (DEBUG FLAG)
let s:debug = 0

" 2ch�F�؂̂��߂̕z��
let s:user_agent_enable = 1
" 2ch�ˑ��f�[�^
let s:encoding = 'cp932'
let s:host = 'www.2ch.net'
let s:remote = '2ch.html'
" 2ch�̃��j���[�擾�p�����f�[�^
let s:menu_host = 'menu.2ch.net'
let s:menu_remotepath = 'bbsmenu.html'
let s:menu_localpath = 'bbsmenu'
" �E�B���h�E���ʎq
let s:buftitle_boardlist  = 'Chalice_2�����˂�_�ꗗ'
let s:buftitle_threadlist = 'Chalice_2�����˂�_�X���ꗗ'
let s:buftitle_thread	  = 'Chalice_2�����˂�_�X���b�h'
let s:buftitle_write	  = 'Chalice_2�����˂�_��������'
let s:buftitle_preview	  = 'Chalice_2�����˂�_�v���r���['
" �u�b�N�}�[�N�����o�b�N�A�b�v�Ԋu�̉���
let s:minimum_backupinterval = 3600
let s:bookmark_filename = 'chalice.bmk'
let s:bookmark_backupname = 'bookmark.bmk'
let s:bookmark_backupsuffix = '.chalice_backup'

" �X�N���v�gID���擾
map <SID>xx <SID>xx
let s:sid = substitute(maparg('<SID>xx'), 'xx$', '', '')
let g:chalice_sid = s:sid
unmap <SID>xx
" �X�N���v�g�̃f�B���N�g�����擾
let s:scriptdir = expand('<sfile>:p:h')

" �o�[�W�����`�F�b�N
let s:verchk_verurl = 'http://www.kaoriya.net/update/chalice-version'
let s:verchk_path = substitute(s:scriptdir, 'plugin$', '', '').'VERSION'
let s:verchk_interval = 86400
let s:verchk_url_1 = s:verchk_verurl
let s:verchk_url_2 = 'http://www.kaoriya.net/#CHALICE'

" �N���t���O
let s:opened = 0
let s:opened_write = 0
let s:dont_download = 0

" �O���R�}���h���s�t�@�C����
let s:cmd_curl = ''
let s:cmd_conv = ''
let s:cmd_gzip = ''

" MATCH PATTERNS
let s:mx_thread_dat = '^[ !\*+x] \(.*\) (\%(\%(\d\+\|???\)/\)\?\(\d\+\)).*\t\+\(\d\+\%(_\d\+\)\?\.\%(dat\|cgi\)\)'
let s:mx_anchor_num = '>>\(\(\d\+\)\%(-\(\d\+\)\)\?\)'
let s:mx_anchor_url = '\(\(h\?ttps\?\|ftp\)://'.g:AL_pattern_class_url.'\+\)'
let s:mx_anchor_www = 'www'.g:AL_pattern_class_url.'\+'
let s:mx_anchor_from = 'From:\s*\([1-9]\d\{,2}\)'
let s:mx_url_parse = 'http://\([^/]\+\)\%(/\([^?#]\+\)\)\?\%(?\([^#]\+\)\)\?\%(#\(.\+\)\)\?'
let s:mx_url_2channel = 'http://\(..\{-\}\)/test/read.cgi\(/[^/]\+\)/\(\d\+\%(_\d\+\)\?\)\(.*\)'
let s:mx_servers_oldkako = '^\(piza\.\|www\.bbspink\|mentai\.2ch\.net/mukashi\|www\.2ch\.net/\%(tako\|kitanet\)\)'
let s:mx_servers_jbbstype = '\%(^jbbs\.shitaraba\.com\|\.\%(machibbs.com$\|machi\.to$\|jbbs\.net\)\)'

let s:mx_servers_shitaraba = '^www\.shitaraba\.com$'
let s:mx_servers_machibbs = '\.\%(machibbs\.com\|machi\.to\)$'
let s:mx_servers_euc = '\%(jbbs\.net\|shitaraba\.com\)'
let s:mx_html2dat_jbbs = '\m^<dt>\d\+\s*���O�F\%(<a href="mailto:\([^"]*\)">\)\?\(.\{-\}\)\%(</a>\)\?\s*���e���F\s*\(.*\)\s*<br>\s*<dd>'
let s:mx_html2dat_2ch = '\m^<dt>\d\+\s*�F\%(<a href="mailto:\([^"]*\)">\)\?\(.\{-\}\)\%(</a>\)\?\s*�F\s*\(.*\)\s*<dd>'

"}}}

"------------------------------------------------------------------------------
" AUTO COMMANDS {{{
" �I�[�g�R�}���h�̐ݒ�

let s:autocmd_installed = 0

function! s:AutocmdInstall()
  if s:autocmd_installed != 0
    return
  else
    let s:autocmd_installed = 1
  endif
  augroup Chalice
    autocmd!
    execute "autocmd BufWriteCmd " . s:buftitle_write . " call <SID>DoWriteBuffer('')"
    execute "autocmd BufDelete " . s:buftitle_write . " call <SID>OnCloseWriteBuffer()"
    execute "autocmd BufEnter " . s:buftitle_boardlist . " call s:Redraw('force')|call s:EchoH('WarningMsg',s:msg_help_boardlist)|normal! 0"
    execute "autocmd BufEnter " . s:buftitle_threadlist . " call s:Redraw('force')|call s:EchoH('WarningMsg',s:opened_bookmark?s:msg_help_bookmark : s:msg_help_threadlist)"
    execute "autocmd BufEnter " . s:buftitle_thread . " call s:Redraw('force')|call s:EchoH('WarningMsg',s:msg_help_thread)"
    execute "autocmd BufDelete " . s:buftitle_threadlist . " if s:opened_bookmark|call s:CloseBookmark()|endif"
    execute "autocmd CursorHold " . s:buftitle_thread . " call s:OpenPreview_autocmd()"
    execute "autocmd CursorHold " . s:buftitle_preview . " call s:OpenPreview_autocmd()"
  augroup END
endfunction

function! s:AutocmdUninstall()
  let s:autocmd_installed = 0
  augroup Chalice
    autocmd!
  augroup END
endfunction

function! s:OnEnterBoardlist()
  call s:Redraw('force')
  call s:EchoH('WarningMsg', s:msg_help_boardlist)
  normal! 0
endfunction

function! s:OnEnterThreadlist()
  call s:Redraw('force')
  if s:opened_bookmark
    call s:EchoH('WarningMsg', s:msg_help_bookmark)
  else
    call s:EchoH('WarningMsg', s:msg_help_threadlist)
  endif
endfunction

function! s:OnEnterThread()
  call s:Redraw('force')
  call s:EchoH('WarningMsg', s:msg_help_threadlist)
endfunction

"}}}

"------------------------------------------------------------------------------
" GLOBAL FUNCTIONS {{{
" �O���[�o���֐�

function! Chalice_GetCacheDir()
  if !exists('s:dir_cache')
    call s:CheckEnvironment()
  endif
  return s:dir_cache
endfunction

function! Chalice_foldmark(id)
  if a:id == 0
    return s:foldmark_0
  elseif a:id == 1
    return s:foldmark_1
endfunction

"}}}

"------------------------------------------------------------------------------
" DEVELOPING FUNCTIONS {{{
" �J���r��֐��������͖�����

function! s:GetHostEncoding(host)
  if AL_hasflag(g:chalice_readoptions, 'noenc')
    return ''
  else
    if a:host =~# s:mx_servers_euc
      if AL_hasflag(&fileencodings, 'euc-jisx0213')
	return 'euc-jisx0213'
      else
	return 'euc-jp'
      endif
    else
      return 'cp932'
    endif
  endif
endfunction

function! s:DatdirOn()
  let datdirtool = AL_basepath(s:scriptdir).'/tools/datdir/2datdir.vim'
  if !filereadable(datdirtool)
    call AL_echokv('datdirtool', datdirtool)
    call AL_echo(s:msg_error_nodatdirtool, 'ErrorMsg')
    return 0
  endif
  execute 'source '.escape(datdirtool, ' ')
  " ���s���ʂ̌���
  let datd = s:GetPath_Datdir()
  let s:datdir_enabled = isdirectory(datd) && filewritable(datd)
  if s:datdir_enabled
    call AL_echo(s:msg_warn_datdirtoolsuccess, 'WarningMsg')
    if exists(':ChaliceDatdirOn')
      delcommand ChaliceDatdirOn
    endif
  else
    call AL_echo(s:msg_error_datdirtoolfailed, 'ErrorMsg')
  endif
  return s:datdir_enabled
endfunction

function! s:HighlightWholeline(linenr, syngroup)
  call AL_execute('match '.a:syngroup.' /^.*\%'.a:linenr.'l.*$/')
endfunction

function! s:StringFormatTime(seconds)
  let sec  = a:seconds
  let min  = sec / 60
  let hour = min / 60
  let day  = hour / 24
  let sec  = sec % 60
  let min  = min % 60
  let hour = hour % 24
  return AL_string_formatnum(day, 2, '0').':'.AL_string_formatnum(hour, 2, '0').':'.AL_string_formatnum(min, 2, '0').':'.AL_string_formatnum(sec, 2, '0')
endfunction

" �N��AA�\��
function! s:StartupAA(filename, wait)
  if !filereadable(a:filename)
    return 0
  endif
  " �o�b�t�@��AA��ǂݍ���
  call s:GoBuf_Thread()
  if line('$') > 1
    call append('$', '')
  endif
  normal! G
  let oldline = line('.')
  silent! execute 'read '.a:filename
  let insrange = line("'[").','.line("']")
  silent! execute insrange.'s/%VERID%/'.s:version.'/g'
  " �A�j���[�V����
  if a:wait >= 0
    " ������
    let spnum = 70
    let spstr = AL_string_multiplication(' ', spnum)
    let save_hlsearch = &hlsearch
    let save_wrap = &wrap
    set nohlsearch
    set nowrap
    silent! execute insrange.'s/^/'.spstr.'/'
    call AL_del_lastsearch()
    redraw
    " �A�j���[�V�������[�v
    let i = 0
    while i < spnum
      silent! execute insrange.'s/^ //'
      redraw
      let wait = a:wait
      while wait > 0
	let wait = wait - 1
      endwhile
      let i = i + 1
    endwhile
    " ��Еt��
    call AL_del_lastsearch()
    let @/ = ''
    let &hlsearch = save_hlsearch
    let &wrap = save_wrap
  endif
  execute oldline
  return 1
endfunction

function! s:AdjustWindowSizeDefault()
  call s:AdjustWindowSize(g:chalice_boardlist_columns, g:chalice_threadlist_lines)
endfunction

function! s:AdjustWindowSize(dirwidth, listheight)
  let winnum = winnr()
  if s:GoBuf_BoardList() >= 0
    execute a:dirwidth.' wincmd |'
  endif
  if s:GoBuf_ThreadList() >= 0
    execute a:listheight.' wincmd _'
  endif
  execute winnum.' wincmd w'
endfunction

function! s:CheckNewVersion(verurl, verpath, vercache, ...)
  if !filereadable(a:verpath)
    return 0
  endif
  let interval = a:0 > 0 ? a:1 : 0

  " �o�[�W�������_�E�����[�h
  if !filereadable(a:vercache) || localtime() - getftime(a:vercache) > interval
    let mx = '^http://\(.*\)/\([^/]*\)$'
    let host  = AL_sscan(a:verurl, mx, '\1')
    let rpath = AL_sscan(a:verurl, mx, '\2')
    call s:HttpDownload(host, rpath, a:vercache, '')
  endif
  if !filereadable(a:vercache)
    return 0
  endif

  " �e�o�[�W�����ԍ����t�@�C������ǂݎ��
  call AL_execute('vertical 1sview ++enc= '.escape(a:verpath, ' '))
  setlocal bufhidden=delete
  let s:version = getline(1)
  call AL_execute('view '.escape(a:vercache, ' '))
  setlocal bufhidden=delete
  let vernew = getline(1)
  silent! bwipeout!

  return AL_compareversion(s:version, vernew) > 0 ? 1 : 0
endfunction

function! s:CheckThreadUpdate(flags)
  if AL_hasflag(a:flags, 'write')
    if exists('b:url')
      call s:HasNewArticle(b:url)
    endif
    call s:GoBuf_Write()
  endif
endfunction

function! s:NextLine()
  if AL_islastline()
    normal! gg
  else
    normal! j
  endif
endfunction

function! s:ViewCursorLine()
  if foldclosed(line('.')) > 0
    normal! zv
  endif
endfunction

"
" ������ۂ����Ƃ�����
"
function! s:Cruise(flags)
  if AL_hasflag(a:flags, 'thread')
    " �X���b�h�ł̏���
    if AL_islastline() && s:opened_bookmark
      call s:GoBuf_ThreadList()
      call s:ViewCursorLine()
      call s:NextLine()
      call s:Cruise(AL_delflag(AL_addflag(a:flags, 'bookmark'), 'thread'))
    else
      call AL_execute("normal! \<C-F>")
    endif
  elseif AL_hasflag(a:flags, 'bookmark')
    while s:opened_bookmark
      " �u�b�N�}�[�N�ł̏���
      call s:ViewCursorLine()
      let curline = getline('.')
      if !s:ParseURL(matchstr(curline, s:mx_anchor_url))
	if exists('g:chalice_cruise_endmark') && g:chalice_cruise_endmark.'X' !=# 'X' && curline =~# '\m^\s*'.Chalice_foldmark(0).'\s*'.g:chalice_cruise_endmark.'$'
	  break
	else
	  call s:NextLine()
	endif
      else
	" �G���g���[���X���b�h�Ȃ�V���`�F�b�N
	normal! z.
	" Hotlink�\��
	call s:HighlightWholeline(line('.'), 'DiffAdd')
	" �X���ǂݍ��݁Bifmodified���́B
	let retval = s:UpdateThread('', s:parseurl_host, s:parseurl_board, s:parseurl_dat, 'continue,ifmodified')
	call s:GoBuf_ThreadList()
	if retval > 0
	  " �X�V���������ꍇ
	  call s:HighlightWholeline(line('.'), 'DiffChange')
	  call s:GoBuf_Thread()
	  call s:AddHistoryJump(s:ScreenLine(), line('.'))
	  while getchar(0) != 0
	  endwhile
	  call AL_echo(s:msg_thread_hasnewarticles, 'WarningMsg')
	else
	  " ���������ꍇ
	  call s:HighlightWholeline(line('.'), 'Constant')
	  call s:NextLine()
	  " �G���[���b�Z�[�W�I��
	  if retval == -3
	    call s:EchoH('Error', s:msg_thread_lost)
	  elseif retval == -2
	    call s:EchoH('Error', s:msg_thread_dead)
	  elseif s:IsBoardMoved(s:parseurl_board, s:parseurl_host)
	    call s:EchoH('Error', s:msg_warn_boardmoved)
	  else
	    if AL_hasflag(a:flags, 'semiauto')
	      call s:EchoH('', s:msg_thread_nonewwait)
	      sleep 5
	      continue
	    else
	      call s:EchoH('', s:msg_thread_nonewarticle)
	    endif
	  endif
	endif
	break
      endif
    endwhile
  endif
endfunction

"
" �������ځ[��������t���O�t�@�C�����쐬����B�������ځ[�񉻂��������ƃX���^
" �C�g�����L���B
"
function! s:AboneThreadDat()
  call s:GoBuf_ThreadList()
  " �o�b�t�@���X���ꗗ�ł͂Ȃ������ꍇ�A���I��
  if b:host == '' || b:board == ''
    return
  endif

  " �J�[�\���̌��݈ʒu����dat�����擾
  let curline = getline('.')
  if curline =~ s:mx_thread_dat
    let title = AL_sscan(curline, s:mx_thread_dat, '\1')
    let dat = AL_sscan(curline, s:mx_thread_dat, '\3')
    let abone = s:GenerateAboneFile(b:host, b:board, dat)
    call AL_mkdir(AL_basepath(abone))
    call AL_execute('redir! >' . abone)
    silent echo strftime("%Y/%m/%d %H:%M:%S " .title)
    silent echo ""
    redir END
    if g:chalice_threadinfo
      call s:FormatThreadInfoWithoutUndo(line('.'), line('.'), 'numcheck')
      call s:WriteFormatedCache_Subject(b:host, b:board)
    endif
  endif
endfunction

"
" �X����.dat���폜����Babone�t�@�C�����������ꍇ�ɂ͂������D�悵�č폜�B
"
function! s:DeleteThreadDat()
  call s:GoBuf_ThreadList()
  " �o�b�t�@���X���ꗗ�ł͂Ȃ������ꍇ�A���I��
  if b:host == '' || b:board == ''
    return
  endif

  " �J�[�\���̌��݈ʒu����dat�����擾
  let curline = getline('.')
  if curline =~ s:mx_thread_dat
    let dat = AL_sscan(curline, s:mx_thread_dat, '\3')
    " host,board,dat���烍�[�J���t�@�C�����𐶐�
    let local = s:GenerateLocalDat(b:host, b:board, dat)
    let abone = s:GenerateAboneFile(b:host, b:board, dat)
    if filereadable(abone)
      " abone�t�@�C��������ΐ�ɏ���
      call delete(abone)
    elseif filereadable(local)
      " dat�t�@�C��������Ώ���
      call delete(local)
      " �t�H�[�}�b�g�L���b�V�����폜
      if s:fcachedir_enabled
	call CACHEMAN_clear(s:fcachedir, s:GetPath_FormatedCache(b:host, b:board, dat))
      endif
    endif
    " �\�����e���X�V
    if g:chalice_threadinfo
      call s:FormatThreadInfoWithoutUndo(line('.'), line('.'), 'numcheck')
      call s:WriteFormatedCache_Subject(b:host, b:board)
    endif
  endif
endfunction

"
" ����������Έ����́A�Ȃ���΃J�[�\������URL�����o���A�X���X�V�̗L����
" �`�F�b�N����B
"
function! s:HasNewArticle(...)
  " �����������͌��ݍs����URL���������o���Ahost/board/dat�𒊏o
  if a:0 > 0
    let url = a:1
  else
    let url = getline('.')
  endif
  let url = matchstr(url, s:mx_url_2channel)
  if url == ''
    return 0
  endif
  let host = AL_sscan(url, s:mx_url_2channel, '\1')
  let board = AL_sscan(url, s:mx_url_2channel, '\2')
  let dat = AL_sscan(url, s:mx_url_2channel, '\3.dat')

  " ���m�̃X���A�q�ɗ��������X���̓`�F�b�N�ΏۊO�Ƃ���
  let local_dat = s:GenerateLocalDat(host, board, dat)
  let local_kako = s:GenerateLocalKako(host, board, dat)
  if !filereadable(local_dat)
    call s:EchoH('Error', s:msg_thread_unknown)
    return 0
  elseif filereadable(local_kako)
    call s:EchoH('Error', s:msg_thread_lost)
    return 0
  endif

  let remote = s:GenerateRemoteDat(host, board, dat)
  let result = s:HttpDownload(host, remote, local_dat, 'continue,head')

  if result == 206
    call s:EchoH('WarningMsg', s:msg_thread_hasnewarticles)
    return 1
  elseif result == 302
    call s:EchoH('Error', s:msg_thread_dead)
    return 0
  else
    call s:EchoH('', s:msg_thread_nonewarticle)
    return 0
  endif
endfunction

"
" URL��Chalice�ŊJ��
"
" Flags:
"   external		�����I�ɊO���u���E�U���g�p����
"   noboardcheck	�ꗗ�`�F�b�N���s�Ȃ�Ȃ�
function! s:HandleURL(url, flag)
  " �ʏ��URL�������ꍇ�A�������ŊO���u���E�U�ɓn���Ă���BURL�̌`���݂�2ch
  " �Ȃ�Γ����ŊJ���B
  if a:url !~ '\(https\?\|ftp\)://'.g:AL_pattern_class_url.'\+'
    return 0
  endif
  if AL_hasflag(a:flag, 'external')
    " �����I�ɊO���u���E�U���g�p����悤�Ɏw�肳�ꂽ
    call s:OpenURL(a:url)
    return 2
  elseif !s:ParseURL(a:url)
    " Chalice�Ŏ�舵����URL�ł͂Ȃ���:
    " ��URL���ǂ�����ꗗ�𗘗p���Ĕ��f���A�Ȃ�΂�����J��
    let oldbuf = bufname('%')
    call s:GoBuf_BoardList()
    let nr = AL_hasflag(a:flag, 'noboardcheck') ? 0 : search('\V'.escape(a:url, "\\"), 'w')
    if nr != 0
      normal! zO0z.
      execute maparg("<CR>")
      call AL_selectwindow(oldbuf)
    else
      call AL_selectwindow(oldbuf)
      call s:OpenURL(a:url)
    endif
    return 2
  else
    " Chalice�Ŏ�舵����URL�̎�

    " �W�����v�q�X�g����ǉ�����
    if !AL_hasflag(a:flag, '\cnoaddhist')
      call s:AddHistoryJump(s:ScreenLine(), line('.'))
    endif
    " �v���r���[�E�B���h�E�����
    if !(g:chalice_preview && AL_hasflag(g:chalice_previewflags, '1'))
      call s:ClosePreview()
    endif

    " s:parseurl_host, s:parseurl_board, s:parseurl_dat,
    " s:parseurl_range_start, s:parseurl_range_end, s:parseurl_range_mode,
    " ��ParseURL()���Őݒ肳���ÖٓI�Ȗ߂�l�B
    if AL_hasflag(a:flag, 'firstarticle')
      call s:OpenThreadOnlyone(s:parseurl_host, s:parseurl_board, s:parseurl_dat)
    else
      call s:OpenThreadNormal(s:parseurl_host, s:parseurl_board, s:parseurl_dat, s:parseurl_range_start, s:parseurl_range_end, s:parseurl_range_mode)
    endif

    " �q�X�g���ɒǉ�(����p:�X���o�b�t�@�ֈړ�)
    if !AL_hasflag(a:flag, '\cnoaddhist')
      call s:AddHistoryJump(s:ScreenLine(), line('.'))
    endif
  endif
  return 1
endfunction

" �w��̃X���b�h��1�������J��
"
" Referenced: HandleURL()
function! s:OpenThreadOnlyone(host, board, dat)
  let mx = '\m^http://\([^/]\+\)/\(.\+\)$'
  let url = s:GenerateThreadURL(a:host, a:board, a:dat, 'onlyone')
  let tmpfile = tempname()
  let result = s:HttpDownload(AL_sscan(url, mx, '\1'), AL_sscan(url, mx, '\2'), tmpfile, 'noagent')
  if result == 200
    " 1�𐮌`
    call s:GoBuf_Thread()
    let save_undolevels = &undolevels
    set undolevels=-1
    call AL_buffer_clear()
    call AL_execute('read ++enc='.s:GetHostEncoding(a:host)." ".tmpfile)
    silent! 1 delete _
    " �^�C�g���̎擾
    let mx = '<title>\(.*\)<\/title>'
    if search(mx, 'W') > 0
      let title = AL_sscan(getline('.'), mx, '\1')
    else
      let title = 'NOTITLE'
    endif
    " �L���ȊO�̓��e���폜
    silent! %substitute/<\/\?dl>/\r/g
    silent! global!/^<dt>1/ delete _
    " HTML��DAT�ɕϊ�
    let data = substitute(getline(1), '\%(<br>\)\+$', '', 'ie')
    if a:host =~ s:mx_servers_jbbstype
      let data = substitute(data, s:mx_html2dat_jbbs, '\2<>\1<>\3<>', 'ie').'<>'
    else
      let data = substitute(data, s:mx_html2dat_2ch, '\2<>\1<>\3<>', 'ie').'<>'
    endif
    " DAT��TXT�ɐ��`���ăo�b�t�@�֓\��t��
    silent! normal! 1G"_dd
    call AL_append_multilines(substitute(DatLine2Text(1, data), "\r", "\<NL>", 'ge'))
    silent! normal! 1G"_dd
    " �X���̃��^����ǉ�
    call append(0, 'Title: '.title)
    call append(1, 'URL: '.s:GenerateThreadURL(a:host, a:board, a:dat, 'raw'))
    call AL_del_lastsearch()
    " �X���ɕK�v�ȕϐ���ݒ�
    let b:host	= a:host
    let b:board	= a:board
    let b:dat	= a:dat
    let b:title	    = s:prefix_thread . title
    let b:title_raw = title
    let &undolevels = save_undolevels
    " �J�[�\����URL�ֈړ�
    normal! 2G
  else
    call s:EchoH('Error', s:msg_thread_dead." ".result)
  endif
  call delete(tmpfile)
endfunction

" �w��X���b�h���J��
"
" Referenced: HandleURL()
function! s:OpenThreadNormal(host, board, dat, rstart, rend, rmode)
  let curarticle = s:UpdateThread('', a:host, a:board, a:dat, 'continue')

  if a:rmode =~ 'r'
    if a:rmode !~ 'l'
      " �񃊃X�g���[�h
      " �\���͈͌��folding
      if a:rend != '$'
	let fold_start = s:GetLnum_Article(a:rend + 1)  - 1
	if 0 < fold_start
	  call AL_execute(fold_start . ',$fold')
	endif
      endif
      " �\���͈͑O��folding
      if a:rstart > 1
	let fold_start = s:GetLnum_Article(a:rmode =~ 'n' ? 1 : 2) - 1
	let fold_end = s:GetLnum_Article(a:rstart) - 2
	if 0 < fold_start && fold_start < fold_end
	  call AL_execute(fold_start . ',' . fold_end . 'fold')
	endif
      endif
      call s:GoThread_Article(a:rstart)
    else
      " ���X�g���[�h('l')
      let fold_start = s:GetLnum_Article(a:rmode =~ 'n' ? 1 : 2) - 1
      let fold_end = s:GetLnum_Article(s:GetThreadLastNumber() - a:rstart + (a:rmode =~ 'n' ? 1 : 2)) - 2
      if 0 < fold_start && fold_start < fold_end
	call AL_execute(fold_start . ',' . fold_end . 'fold')
      endif
      if !s:GoThread_Article(curarticle)
	normal! Gzb
      endif
    endif
  endif
endfunction

function! s:GetThreadLastNumber()
  return getbufvar(s:buftitle_thread, 'chalice_lastnum')
endfunction

"
" URL���O���u���E�U�ɊJ������
"
function! s:OpenURL(url)
  let retval = AL_open_url(a:url, g:chalice_exbrowser)
  call s:Redraw('force')
  if retval
    let msg =  "Open " . a:url . " with your browser"
    " �J����URL��DiffChange�Ńn�C���C�g�\��
    execute 'match DiffChange /\V'.escape(a:url, '/').'/'
  else
    let msg = "Chalice:OpenURL is not implemented:" . a:url
  endif
  call s:EchoH('WarningMsg', msg)
  return retval
endfunction

function! s:GetAnchorCurline()
  " �J�[�\�����̃����N��T���o���B�Ȃ���Ό�������đO���փT�[�`
  let mx = "\\%(\\%(".s:mx_anchor_num."\\)\\|\\%(".s:mx_anchor_url."\\)\\|\\%(".s:mx_anchor_www."\\)\\|\\%(".s:mx_anchor_from."\\)\\)"
  let str = AL_matchstr_cursor(mx)
  if str =~ s:mx_anchor_from
    let str = '>>'.AL_sscan(str, s:mx_anchor_from, '\1')
  endif
  return str
endfunction

"
" �������ݓ��̃����N������
"
function! s:HandleJump(flag)
  "call s:GoBuf_Thread()

  let anchor = s:GetAnchorCurline()

  if anchor =~ s:mx_anchor_num
    let anchor = matchstr(anchor, s:mx_anchor_num)
    " �X���̋L���ԍ��������ꍇ
    let num = AL_sscan(anchor, s:mx_anchor_num, '\2')
    if AL_hasflag(a:flag, '\cinternal')
      let oldsc = s:ScreenLine()
      let oldcur = line('.')
      let lnum = s:GoThread_Article(num)
      if lnum > 0
	call AL_execute(lnum . "foldopen!")
	" �Q�ƌ����q�X�g���ɓ����
	call s:AddHistoryJump(oldsc, oldcur)
	" �Q�Ɛ���q�X�g���ɓ����
	call s:AddHistoryJump(s:ScreenLine(), line('.'))
      endif
    elseif AL_hasflag(a:flag, 'external')
      if b:host != '' && b:board != '' && b:dat != ''
	let num = substitute(anchor, s:mx_anchor_num, '\1', '')
	call s:OpenURL(s:GenerateThreadURL(b:host, b:board, b:dat, 'raw') .num.'n')
      endif
    endif
  elseif anchor =~ s:mx_anchor_url
    let url = substitute(matchstr(anchor, s:mx_anchor_url), '^ttp', 'http', '')
    return s:HandleURL(url, a:flag)
  elseif anchor =~ s:mx_anchor_www " http:// ����URL�̏���
    let url = 'http://' . matchstr(anchor, s:mx_anchor_www)
    return s:HandleURL(url, a:flag)
  else
    call s:EchoH('ErrorMsg', s:msg_error_cantjump)
  endif
endfunction

function! s:UpdateThreadInfo(host, board, dat)
  if g:chalice_threadinfo
    call s:GoBuf_ThreadList()
    if !exists('b:host') || !exists('b:board')
      return
    endif
    if b:host . b:board ==# a:host . a:board
      if a:dat != '' && search(a:dat, 'w')
	call s:FormatThreadInfoWithoutUndo(line('.'), line('.'), 'numcheck')
	call s:WriteFormatedCache_Subject(b:host, b:board)
      endif
    endif
    call s:GoBuf_Thread()
  endif
endfunction

function! s:DatDownload_2ch(host, remote, local_dat, flags)
  if 1 && has('byte_offset') && AL_hasflag(a:flags, 'continue') && getfsize(a:local_dat) > 0
    " DAT�̍Ō��1�s�����悤�Ƀ_�E�����[�h���邽�߂ɁA���m�ȃA�h���X�𑪒�
    call AL_execute('1vsplit ++enc= ++bad=keep '.a:local_dat)
    let continue_at = line2byte('$') - 1
    let lastline = line('$')
    silent! bwipeout!
    " ���_�E�����[�h���s
    let tmpfile = tempname()
    let retval = s:HttpDownload2(s:GenerateHostPathUri(a:host, a:remote), tmpfile, continue_at, a:local_dat)
    " �_�E�����[�h�̌��ʂ�����
    if retval == 304
      call delete(tmpfile)
      return retval
    elseif retval == 206
      " �Ō��1�s������������Ă��邩�`�F�b�N����
      "	  ����Ă��遨DAT�X�V
      "	  ����ĂȂ����t�@�C���������đS�擾��
      call AL_execute('1vsplit ++enc= ++bad=keep '.a:local_dat)
      call AL_execute('$read ++enc= ++bad=keep '.tmpfile)
      call delete(tmpfile)
      if getline(lastline) ==# getline(lastline + 1)
	if line('$') > lastline + 1
	  call AL_execute(lastline." delete _")
	  silent! call AL_write();
	endif
	silent! bwipeout!
	return retval
      else
	call AL_execute(lastline." delete _")
	" DAT�ɂ��ځ[�񂪐������Ɛ���
	silent! bwipeout!
	call delete(a:local_dat)
      endif
    elseif retval == 416
      " DAT�ɂ��ځ[�񂪐����ĒZ���Ȃ����Ɛ���
      call delete(a:local_dat)
    endif
    " ���_�E�����[�h�Ɏg�����t�@�C�����폜
    if getfsize(tmpfile) >= 0
      call delete(tmpfile)
    endif
  endif
  return s:HttpDownload(a:host, a:remote, a:local_dat, a:flags)
endfunction

function! s:DatCatchup_2ch(host, board, dat, flags)
  let local = ''
  let prevsize = 0
  let oldarticle = 0
  " ��{�헪
  "   1. kako_dat_*������Έȉ��̓X���[
  "   2. �����ꍇ�ɂ�dat_*��(����)�擾�����݂�
  "   3. HTTP�ԓ��R�[�h���`�F�b�N���A�X���������Ȃ�ȉ��̓X���[
  "   4. �q�ɓ��肵�Ă�����Akako_dat_*�Ƃ��đS�̂��擾����
  "   5. �q�ɂŌ�����Ȃ����offlaw���g�p���Ă݂�
  "   6. ����dat_*�͕��u
  let remote = s:GenerateRemoteDat(a:host, a:board, a:dat)
  let local_dat  = s:GenerateLocalDat(a:host, a:board, a:dat)
  let local_kako = s:GenerateLocalKako(a:host, a:board, a:dat)
  if filereadable(local_kako)
    " �菇1
    let local = local_kako
    let prevsize = getfsize(local_kako)
    let oldarticle = s:CountLines(local_kako)
  elseif filereadable(local_dat) && AL_hasflag(a:flags, 'noforce')
    " noforce�w�莞�̓l�b�g�A�N�Z�X�������I�ɍs�Ȃ�Ȃ�(�Ӗ����c��)
    let local = local_dat
    let prevsize = getfsize(local_dat)
    let oldarticle = s:CountLines(local_dat)
  else
    " �X���b�h�̓��e���_�E�����[�h
    " �t�@�C���̌��̃T�C�Y���o���Ă���
    if filereadable(local_dat)
      let prevsize = getfsize(local_dat)
      let oldarticle = s:CountLines(local_dat)
    endif
    " �菇2
    let didntexist = filereadable(local_dat) ? 0 : 1
    if didntexist
      call AL_mkdir(AL_basepath(local_dat))
    endif
    let result = s:DatDownload_2ch(a:host, remote, local_dat, a:flags)
    if result < 300 || result == 304 || result == 416
      " �菇3
      let local = local_dat
      " (�K�v�Ȃ��)�X���ꗗ�̃X�������X�V
      call s:UpdateThreadInfo(a:host, a:board, a:dat)
      " TODO: 416�̎���2�ʂ�̉\��������B���ځ[�񔭐��Ŗ{���ɔ͈͊O���w��
      " �����̂��AApache���V�����ꍇ�͍��������݂��Ȃ����B��҂ɂ��Ă͌Â�
      " Apache��200��Ԃ��̂��Ԉ���Ă���B�c�{���͂��ځ[�񌟏o�Ɏg��������
      " ���̂����A������Ɩ����B
    else
      " HTTP�G���[���ɁA���X�Ȃ������t�@�C�����o���Ă�����S�~�Ƃ��ď���
      if didntexist && filereadable(local_dat)
	call delete(local_dat)
      endif
      " �菇4
      if !AL_hasflag(a:flags, 'ifmodified')
	let idstr = matchstr(a:dat, '\d\+')
	" �V�X���b�h(1000000000�Ԉȍ~)�͊i�[�ꏊ�������ɈقȂ�
	let remote = strpart(idstr, 0, 3)
	if strlen(idstr) > 9
	  let remote = remote. strpart(idstr, 3, 1) .'/'. strpart(idstr, 0, 5)
	endif
	let remote = a:board.'/kako/'.remote.'/'.a:dat
	" ���`���̉ߋ����O�T�[�o�ł̓��O�͈��k����Ȃ�
	if a:host.a:board !~ s:mx_servers_oldkako
	  let remote = remote.'.gz'
	  let local_kako = local_kako.'.gz'
	endif
	" 2�x�ڂ̐����A�_�E�����[�h
	call AL_mkdir(AL_basepath(local_kako))
	let result = s:HttpDownload(a:host, remote, local_kako, '')
	if result == 200 && filereadable(local_kako)
	  if local_kako =~ '\.gz$'
	    call s:Gunzip(local_kako)
	    let local_kako = substitute(local_kako, '\.gz$', '', '')
	  endif
	  let local = local_kako
	else
	  " HTML���҂��Ɛ��������
	  call delete(local_kako)
	  " �菇5
	  " DAT�����擾���s(�v���F��)
	  let local_kako = s:GenerateLocalKako(a:host, a:board, a:dat)
	  if s:GetOfflawDat(a:host, a:board, a:dat, local_kako)
	    let local = local_kako
	  else
	    " offlaw�����Ȃ���Ί���DAT
	    if filereadable(local_dat)
	      let local = local_dat
	    endif
	  endif
	endif " �菇4
      endif
    endif
  endif
  if local == '' && !AL_hasflag(a:flags, 'ifmodified')
    " �G���[: �X��������HTML���҂�
    call AL_buffer_clear()
    call setline(1, 'Error: '.s:msg_error_nothread)
    call append('$', 'Error: '.s:msg_error_accesshere)
    call append('$', '')
    call append('$', '  '.s:GenerateThreadURL(a:host, a:board, a:dat))
    let b:host = a:host
    let b:board = a:board
    let b:dat = a:dat
    let b:title = s:prefix_thread
    let b:title_raw = ''
    normal! G^
    return 0
  endif

  let b:datutil_datsize = getfsize(local)
  " �X�V�������ꍇ�͑��I��
  if AL_hasflag(a:flags, 'ifmodified') && prevsize >= b:datutil_datsize
    if local ==# local_dat
      return -1
    elseif local ==# local_kako
      return -3
    else
      return -2
    endif
  endif

  " �s�{�ӂȃO���[�o��(�o�b�t�@)�ϐ��̎g�p
  let b:chalice_local = local
  return oldarticle + 1
endfunction

"
" �X���b�h�̍X�V���s�Ȃ�
"   ifmodified���w�肵���ꍇ�ɂ́A�X���ɍX�V���Ȃ������ۂɃX���͕\��������-1
"   ��Ԃ��B�ʏ�̓X���̎擾�������̐擪�L���ԍ���Ԃ��B
"
function! s:UpdateThread(title, host, board, dat, flags)
  call s:GoBuf_Thread()
  if a:title != ''
    " �X���̃^�C�g�����o�b�t�@���ɐݒ�
    let b:title = s:prefix_thread . a:title
    let b:title_raw = a:title
  endif
  " �o�b�t�@�ϐ���host,board,dat����������쐬(�R�s�[�����ǂ�)
  let host  = a:host  != '' ? a:host  : b:host
  let board = a:board != '' ? a:board : b:board
  let dat   = a:dat   != '' ? a:dat   : b:dat
  if host == '' || board == '' || dat == ''
    " TODO: �����G���[�������~����
    return -1
  endif

  " dat�t�@�C�����X�V����
  let newarticle = s:DatCatchup(host, board, dat, a:flags)
  " �g�p����dat�t�@�C�������擾����
  if exists('b:chalice_local')
    let local = b:chalice_local
    unlet! b:chalice_local
  else
    let local = ''
  endif

  " �G���[�̏ꍇ�͏I��
  if newarticle <= 0
    return newarticle
  endif

  " �X���b�h���o�b�t�@�Ƀ��[�h���Đ��`
  if a:host != '' || a:board != '' || a:dat != ''
    " �J���ׂ��X��(URL)���قȂ��Ă���̂ŁA�o�b�t�@�ϐ��֊i�[
    let b:host = host
    let b:board = board
    let b:dat = dat
    call s:IsBoardMoved(board, host)
  endif
  " ���`���
  if AL_hasflag(a:flags, 'ignorecache')
    let title = s:FormatThread(local, 'ignorecache')
  else
    let title = s:FormatThread(local)
  endif
  " ���dat���̃^�C�g�����g�p����
  let b:title = s:prefix_thread . title
  let b:title_raw = title

  if !s:GoThread_Article(newarticle)
    normal! Gzb
  endif
  call s:Redraw('force')
  " 'nostartofline'�΍�
  normal! 0
  " >>1�v���r���[
  if g:chalice_preview && AL_hasflag(g:chalice_previewflags, '1')
    call s:OpenPreview('>>1')
  endif
  return newarticle
endfunction

"
" ���e���X�V����
"
function! s:UpdateBoard(title, host, board, flag)
  call s:CloseBookmark()
  " �X���b�h���X�g�Ɉړ����� 1.�^�C�g�� 2.�z�X�g 3.��ID��ݒ肷��
  call s:GoBuf_ThreadList()
  if a:title != ''
    let b:title = s:prefix_board . a:title
    let b:title_raw = a:title
  else
    let b:title = s:prefix_board . b:title_raw
  endif
  if a:host != ''
    let b:host = a:host
  endif
  if a:board != ''
    let b:board = a:board
  endif
  if b:host == '' || b:board == ''
    " TODO: �����G���[�������~����
    return
  endif

  " �p�X�𐶐����ăX���ꗗ���_�E�����[�h
  let local = s:GenerateLocalSubject(b:host, b:board)
  let remote = s:GenerateRemoteSubject(b:host, b:board)
  if s:fcachedir_enabled
    " DAT���`�L���b�V��
    let cacheid = s:GetPath_FormatedCache_Subject(b:host, b:board)
    let fcachedfile = CACHEMAN_update(s:fcachedir, cacheid)
  endif
  let updated = 0
  let isexpired = localtime() - getftime(local) > g:chalice_reloadinterval_threadlist
  if AL_hasflag(a:flag, 'force') || !filereadable(local) || isexpired
    " �����l�b�g�A�N�Z�X��subject.txt�ǂݍ���
    call AL_mkdir(AL_basepath(local))
    call s:HttpDownload(b:host, remote, local, '')
    let updated = 1
    " �t�H�[�}�b�g�L���b�V�����폜����
    if s:fcachedir_enabled
      call CACHEMAN_clear(s:fcachedir, cacheid)
    endif
  endif

  " �X���ꗗ�𐮌`�A�������̓L���b�V����ǂݍ���
  let save_undolevels = &undolevels
  set undolevels=-1
  if s:fcachedir_enabled && filereadable(fcachedfile)
    " �t�H�[�}�b�g�L���b�V����ǂݍ���
    call AL_buffer_clear()
    call AL_execute('read ++enc= ' . escape(fcachedfile, ' '))
    1 delete _
  else
    " �X���ꗗ���o�b�t�@�Ƀ��[�h���Đ��`
    call AL_buffer_clear()
    call AL_execute("read " . local)
    call AL_execute("g/^$/delete _") " ��s���폜
    " ���`
    call s:FormatBoard()
    " ���`�ς݃L���b�V���ɕۑ�����
    if s:fcachedir_enabled
      call AL_write(fcachedfile)
    endif
  endif
  " ���[�J�����ځ[��̃X�����폜
  if !AL_hasflag(a:flag, 'showabone')
    call AL_execute('silent! g/^x/delete _')
    call AL_del_lastsearch()
  endif
  " �擪�s�ֈړ�
  silent! normal! gg0
  let &undolevels = save_undolevels

  if !updated
    call s:Redraw('force')
    call s:EchoH('WarningMsg', s:msg_warn_oldthreadlist)
  endif
endfunction

function! s:Reformat(target)
  if a:target ==# 'thread'
    let save_dont_download = s:dont_download
    let s:dont_download = 1
    call s:UpdateThread('', '', '', '', 'ignorecache,force')
    let s:dont_download = save_dont_download
  else
  endif
endfunction

" �w�肳�ꂽ���ړ]�����\�������邩���`�F�b�N����B
"   �ړ]�����\��������ꍇ��1�A�Ȃ����0��Ԃ�
function! s:IsBoardMoved(board, host)
  let bid = substitute(a:board, '^/', '', '')
  if !exists('s:movechecked_' . bid) || s:movechecked_{bid} == ""
    let curhost = ""
    " �ꗗ����Y������URL��T���o���āA�z�X�g�������擾(curhost)����
    let oldbuf = bufname('%')
    call s:GoBuf_BoardList()
    let mx = '\mhttp://\([^/]*\)' . a:board . '/'
    let nr = search(mx, "w")
    if nr > 0
      let curhost = AL_sscan(getline(nr), mx, '\1')
    endif
    call AL_selectwindow(oldbuf)
    let s:movechecked_{bid} = curhost
  endif
  return a:host != s:movechecked_{bid} ? 1 : 0
endfunction

"}}}

"------------------------------------------------------------------------------
" FIXED FUNCTIONS {{{
" �b��I�Ɍł܂����֐��Q

if has('perl')
  function! s:CountLines_perl(target)
    perl << END_PERL
      my $file = VIM::Eval('a:target');
      open IN, $file;
      binmode IN;
      1 while <IN>;
      VIM::DoCommand('let lines = '.$.);
      close IN;
END_PERL
    return lines
  endfunction
endif

function! s:CountLines(target)
  if filereadable(a:target)
    if has('perl')
      let lines = s:CountLines_perl(a:target)
    else
      call AL_execute('vertical 1sview ++enc= '.a:target)
      let lines = line('$')
      silent! bwipeout!
    endif
  else
    let lines = 0
  endif
  return lines
endfunction

function! s:Gunzip(filename)
  if filereadable(a:filename) && a:filename =~ '\.gz$'
    call s:DoExternalCommand(s:cmd_gzip . ' -d -f ' . AL_quote(a:filename))
    if filereadable(a:filename)
      call rename(a:filename, substitute(a:filename, '\.gz$', '', ''))
    endif
  endif
endfunction

function! s:Redraw(opts)
  if g:chalice_noredraw
    return
  endif
  let cmd = 'redraw'
  if AL_hasflag(a:opts, 'force')
    "let cmd = cmd . '!'
  endif
  if AL_hasflag(a:opts, 'silent')
    let cmd = 'silent! ' . cmd
  endif
  execute cmd
endfunction

" �X�N���[���ɕ\������Ă���擪�̍s�ԍ����擾����
function! s:ScreenLine()
  let wline = winline() - 1
  silent! normal! H
  let retval = line('.')
  while wline > 0
    call AL_execute('normal! gj')
    let wline = wline - 1
  endwhile
  return retval
endfunction

function! s:ScreenLineJump(scline, curline)
  " ��̂̈ʒu�܂ŃW�����v
  let curline = a:curline > 0 ? a:curline - 1 : 0
  call AL_execute('normal! ' . (a:scline + curline) . 'G')
  " �ړI�ʒu�Ƃ̍����v��
  let offset = a:scline - s:ScreenLine()
  if offset < 0
    call AL_execute('normal! ' . (-offset) . "\<C-Y>")
  elseif offset > 0
    call AL_execute('normal! ' . offset . "\<C-E>")
  endif
  " �X�N���[�����ł̃J�[�\���ʒu��ݒ肷��
  call AL_execute('normal! H')
  while curline > 0
    call AL_execute('normal! gj')
    let curline = curline - 1
  endwhile
endfunction

"
" �n�C���C�g���w�肵�����b�Z�[�W�\��
"
function! s:EchoH(hlname, msgstr)
  call AL_echo(a:msgstr, a:hlname)
endfunction

"
" Chalice�I��
"
function! s:ChaliceClose(flag)
  if !s:opened
    return
  endif
  " �K�v�Ȃ�ΏI���̈ӎv���m�F����
  if !g:chalice_noquery_quit && !AL_hasflag(a:flag, 'all')
    if confirm(s:msg_confirm_quit, s:choice_yn, 2, "Question") == 2
      return
    endif
  endif

  " �������݃o�b�t�@�������I������. 
  " �d�l�ύX: �������߂�o�b�t�@�������Ă���������
  if s:opened_write
    call s:GoBuf_Write()
    silent! close!
  endif

  " �u�b�N�}�[�N���J����Ă����ꍇ���邱�Ƃŕۑ�����
  if s:opened_bookmark
    call s:CloseBookmark()
  endif

  silent! call s:AutocmdUninstall()
  silent! call s:CommandUnregister()

  " �ғ����Ԃ��v�Z
  let timestr = ''
  if 1
    let wasted = localtime() - s:start_time
    let timestr = s:label_wastetime.' '.s:StringFormatTime(wasted)
    " �ݐωғ����Ԃ�ۑ�
    if exists('s:wasted_time')
      let s:wasted_time = s:wasted_time + wasted
      let waste_file = s:dir_cache.'WASTED'
      call AL_execute('1vsplit '.waste_file)
      call AL_buffer_clear()
      call setline(1, s:wasted_time)
      call AL_write()
      silent! bwipeout!
      let timestr = timestr.', '.s:label_wastetime_sum.' '.s:StringFormatTime(s:wasted_time)
    endif
  endif

  if AL_hasflag(a:flag, 'all')
    execute "qall!"
  endif
  let s:opened = 0

  " �W�����v�������N���A
  call s:JumplistClear()

  " �F�؃f�[�^���N���A
  call s:ResetSession()

  " �ύX�����O���[�o���I�v�V�����̕��A
  let &charconvert = s:charconvert
  if g:chalice_columns > 0
    let &columns = s:columns
  endif
  let &equalalways = s:equalalways
  let &foldcolumn = s:foldcolumn
  let &gdefault = s:gdefault
  let &ignorecase = s:ignorecase
  let &lazyredraw = s:lazyredraw
  let &more = s:more
  let &wrapscan = s:wrapscan
  let &winwidth = s:winwidth
  let &winheight = s:winheight
  let &scrolloff = s:scrolloff
  let &statusline = s:statusline
  let &titlestring = s:titlestring

  " Chalice�֘A�̃o�b�t�@���Ă�wipeout����B
  call AL_execute("bwipeout " . s:buftitle_write)
  silent! new
  silent! only!
  call s:Redraw('silent')

  " �I�����b�Z�[�W
  let extramsg = timestr == '' ? '' : ' ('.timestr.')'
  call s:EchoH('WarningMsg', s:msg_chalice_quit.extramsg)
endfunction

function! s:CharConvert()
  if v:charconvert_from == 'cp932' && v:charconvert_to == 'utf-8' && s:cmd_conv != ''
    call s:DoExternalCommand(s:cmd_conv.' '.v:fname_in.'>'.v:fname_out)
    return 0
  elseif v:charconvert_from == 'cp932' && v:charconvert_to == 'euc-jp' && s:cmd_conv != ''
    call s:DoExternalCommand(s:cmd_conv .'<'. v:fname_in .'>'. v:fname_out)
    return 0
  else
    return 1
  endif
endfunction

if s:debug
  function! ChaliceDebug()
    echo "s:sid=".s:sid
    echo "s:cmd_curl=".s:cmd_curl
    echo "s:cmd_conv=".s:cmd_conv
    echo "s:cmd_gzip=".s:cmd_gzip
    if exists('s:dir_cache')
      echo "s:dir_cache=".s:dir_cache
    endif
    echo "g:chalice_bookmark=".g:chalice_bookmark
  endfunction
endif

"
" ��������`�F�b�N
"
function! s:CheckEnvironment()
  " MacOSX�ł͕K�v�Ȃ��/usr/local/bin���p�X�ɒǉ�����
  if has('macunix') && $PATH =~# '\m\%(^\|:\)/usr/local/bin/\?\%(:\|$\)' && isdirectory('/usr/local/bin')
    let $PATH = '/usr/local/bin:'.$PATH
  endif

  " cURL�̃p�X���擾
  let s:cmd_curl = AL_hascmd('curl')

  " ��CP932���ł̓R���o�[�^���擾����K�v������B
  if &encoding !=# 'cp932' && &encoding !=# 'utf-8'
    if AL_hascmd('qkc') != ''
      let s:cmd_conv = 'qkc -e -u'
    elseif AL_hascmd('nkf') != ''
      let s:cmd_conv = 'nkf -e -x'
    else
      call s:EchoH('ErrorMsg', s:msg_error_noconv)
      return 0
    endif
  elseif &encoding == 'utf-8'
    let s:cmd_conv = 'iconv -c -f cp932 -t utf-8'
  else
    let s:cmd_conv = ''
  endif

  " gzip��T��
  let s:cmd_gzip = AL_hascmd('gzip')
  if s:cmd_gzip == ''
    call s:EchoH('ErrorMsg', s:msg_error_nogzip)
    return 0
  endif

  " �f�B���N�g�����\�z
  if exists('g:chalice_cachedir') && isdirectory(g:chalice_cachedir)
    let s:dir_cache = substitute(g:chalice_cachedir, '[^\/]$', '&/', '')
  else
    let s:dir_cache = g:chalice_basedir . '/cache/'
  endif
  " cookie�t�@�C���ݒ�
  if !exists('g:chalice_cookies')
    let g:chalice_cookies = s:dir_cache . 'cookie'
  endif
  " �u�b�N�}�[�N���\�z
  if g:chalice_bookmark == ''
    let g:chalice_bookmark = g:chalice_basedir . '/' . s:bookmark_filename
  endif
  " �������݃��O�t�@�C�����\�z
  let s:chalice_writelogfile = s:dir_cache . 'write.log'

  " �L���b�V���f�B���N�g���̕ۏ�
  if !isdirectory(s:dir_cache)
    call AL_mkdir(s:dir_cache)
    if !isdirectory(s:dir_cache)
      call s:Redraw('force')
      call s:EchoH('ErrorMsg', s:msg_error_nocachedir)
      return 0
    endif
  endif

  " ��dat�t�@�C�����Ȃ����DATDIR���쐬����
  let datfiles = glob(s:dir_cache.'dat_*')
  let datd = s:GetPath_Datdir()
  if AL_countlines(datfiles) == 0 && !isdirectory(datd)
    call AL_mkdir(s:GetPath_Datdir())
  endif
  " DATDIR���L�������ׂ�
  let s:datdir_enabled = isdirectory(datd) && filewritable(datd)

  " DATDIR���L���Ȃ�΃t�H�[�}�b�g�L���b�V����L���ɂ���
  let s:fcachedir_enabled = 0
  if s:datdir_enabled
    let s:fcachedir = s:dir_cache.'format.d'
    if AL_mkdir(s:fcachedir)
      let s:fcachedir_enabled = 1
      call CACHEMAN_flush(s:fcachedir, g:chalice_formatedcache_expire)
    endif
  endif

  return 1
endfunction

"
" Chalice�w���v���C���X�g�[��
"
function! s:HelpInstall(scriptdir)
  " �ȑO�A���̊֐���plugin�̓ǂݍ��ݎ��Ɏ��s����邱�Ƃ��������̂ŁAAL_*���g
  " ���Ȃ������B���݂͂��̂悤�Ȃ��Ƃ͂Ȃ��Ȃ������A���̖��c��AL_*�͎g�p����
  " ���Ȃ��B

  let basedir = substitute(a:scriptdir, 'plugin$', 'doc', '')
  if has('unix')
    let docdir = $HOME . '/.vim/doc'
    if !isdirectory(docdir)
      call system('mkdir -p ' . docdir)
    endif
  else
    let docdir = basedir
  endif
  let helporig = basedir . '/chalice.txt.cp932'
  let helpfile = docdir . '/chalice.txt'
  let tagsfile = docdir . '/tags'

  " �����R�[�h�̃R���o�[�g
  if !filereadable(helpfile) || (filereadable(helporig) && getftime(helporig) > getftime(helpfile))
    silent execute "sview " . helporig
    set fileencoding=japan fileformat=unix
    call AL_write(helpfile)
    silent! bwipeout!
  endif

  " tags�̍X�V
  if !filereadable(tagsfile) || getftime(helpfile) > getftime(tagsfile)
    silent execute "helptags " . docdir
  endif
endfunction

"
" Chalice�J�n
"
function! s:ChaliceOpen()
  if s:opened
    return
  endif

  " ������̃`�F�b�N
  if !s:CheckEnvironment()
    return
  endif

  call s:AutocmdInstall()

  " (�K�v�Ȃ��)�w���v�t�@�C�����C���X�g�[������
  if !AL_hasflag(g:chalice_startupflags, 'nohelp')
    silent! call s:HelpInstall(s:scriptdir)
  endif

  " �ύX����O���[�o���I�v�V�����̕ۑ�
  let s:opened = 1
  let s:charconvert = &charconvert
  let s:columns = &columns
  let s:equalalways = &equalalways
  let s:foldcolumn = &foldcolumn
  let s:gdefault = &gdefault
  let s:ignorecase = &ignorecase
  let s:lazyredraw = &lazyredraw
  let s:more = &more
  let s:wrapscan = &wrapscan
  let s:winwidth = &winwidth
  let s:winheight = &winheight
  let s:scrolloff = &scrolloff
  let s:statusline = &statusline
  let s:titlestring = &titlestring

  " �O���[�o���I�v�V������ύX
  if s:cmd_conv != ''
    let &charconvert = s:sid . 'CharConvert()'
  endif
  if g:chalice_columns > 0
    let &columns = g:chalice_columns
  endif
  " set equalalways�����u�ԂɁA�����������s�Ȃ��Ă��܂��̂�plugin��ʂ���
  " noequalalways�ɂ����B
  set noequalalways
  set foldcolumn=0
  set nogdefault
  set ignorecase
  set lazyredraw
  set nomore
  set wrapscan
  set winheight=8
  set winwidth=15
  set scrolloff=0
  let &statusline = '%<%{' . s:sid . 'GetBufferTitle()}%='.g:chalice_statusline.'%{'.s:sid.'GetDatStatus()} %{'.s:sid.'GetStatus_ThreadNum()}'
  " let &titlestring = s:label_vimtitle " UpdateTitleString()�Q��

  " foldmarks�̏�����
  let mx = '^\(.\)\(.\)$'
  let foldmarks = '����'
  if exists('g:chalice_foldmarks') && g:chalice_foldmarks =~ mx
    let foldmarks = g:chalice_foldmarks
  endif
  let s:foldmark_0 = AL_sscan(foldmarks, mx, '\1')
  let s:foldmark_1 = AL_sscan(foldmarks, mx, '\2')

  " �N���ŏI����
  call s:CommandRegister()
  call s:OpenAllChaliceBuffers()
  call s:AdjustWindowSizeDefault()

  " ������l�b�g�A�N�Z�X�̑O�ɃI�t���C�����[�h�t���O��ݒ�
  let s:dont_download = AL_hasflag(g:chalice_startupflags, 'offline') ? 1 : 0

  call s:UpdateBoardList(0)

  " �o�[�W�����`�F�b�N
  if 1 && !AL_hasflag(g:chalice_startupflags, 'novercheck')
    let ver_cache = s:dir_cache.'VERSION'
    if 0 < s:CheckNewVersion(s:verchk_verurl, s:verchk_path, ver_cache, s:verchk_interval)
      call s:GoBuf_Thread()
      call AL_buffer_clear()
      call setline(1, 'Info: '.s:msg_error_newversion)
      call append('$', 'Info: '.s:msg_error_doupdate)
      call append('$', 'Info: '.s:msg_error_accesshere)
      call append('$', '')
      call append('$', '  '.s:verchk_url_1)
      call append('$', '  '.s:verchk_url_2)
      let b:title = s:prefix_thread
      let b:title_raw = ''
      normal! G^
    endif
  endif

  " �w�肳�ꂽ�ꍇ�͞x���J���Ă���
  if AL_hasflag(g:chalice_startupflags, 'bookmark')
    silent! call s:OpenBookmark()
  endif

  " �N��AA�\��
  let aaflag = AL_getflagparam(g:chalice_startupflags, 'aa')
  if 1 && aaflag !=# 'no'
    let startup = g:chalice_basedir.'/startup.aa'
    if !filereadable(startup)
      let startup = s:scriptdir.'/../startup.aa'
    endif
    call s:StartupAA(startup, aaflag ==# 'noanime' ? -1 : g:chalice_animewait)
  endif

  " �ݐωғ����Ԃ�\��
  if 1
    let s:start_time = localtime()
    let waste_file = s:dir_cache.'WASTED'
    if filereadable(waste_file)
      call AL_execute('vertical 1sview ++enc= '.waste_file)
      setlocal bufhidden=delete
      let s:wasted_time = getline(1) + 0
      silent! bwipeout!
    else
      let s:wasted_time = 0
    endif
    call s:GoBuf_Thread()
    call append('$', 'Info: '.s:label_wastetime_sum.' '.s:StringFormatTime(s:wasted_time))
    call append('$', 'Info: '.s:msg_warn_dontusetoomuch)
  endif

  " �J�[�\���������ʒu�ֈړ�����
  if AL_hasflag(g:chalice_startupflags, 'bookmark')
    call s:GoBuf_ThreadList()
  else
    call s:GoBuf_BoardList()
  endif

  " �J�n���b�Z�[�W�\��
  call s:UpdateTitleString()
  call s:Redraw('silent')
  call s:EchoH('WarningMsg', s:msg_chalice_start)
endfunction

" �^�C�g���������ݒ肷��B���݂�Chalice�̏�Ԃɉ�����������ɂȂ�B
function! s:UpdateTitleString()
  if exists('g:chalice_titlestring') && g:chalice_titlestring != ''
    let str = g:chalice_titlestring
  else
    let str = s:label_vimtitle
  endif
  if s:dont_download
    let str = str . ' ' . s:label_offlinemode
  endif
  let &titlestring = str
endfunction

function! s:ToggleNetlineState()
  " �I�t���C�����[�h���g�O������
  let s:dont_download = s:dont_download ? 0 : 1
  call s:UpdateTitleString()
  call s:EchoH('WarningMsg', s:dont_download ? s:msg_warn_netline_off : s:msg_warn_netline_on)
endfunction

"
" �O���R�}���h�����s
"   verbose���x���ɉ��������@�Ŏ��s����B
"
function! s:DoExternalCommand(cmd)
  let extcmd = a:cmd
  if has('win32') && &shell =~ '\ccmd'
    "let extcmd = '"' . extcmd . '"'
    " ���̂��̏������K�v�Ȃ̂��킩��Ȃ�(�v���o���Ȃ�)�B���p������&�Ȃǂ̓�
    " �ꕶ��������Ɛ��������߂���Ȃ���肪����A�����������邽�߂Ɏb��I
    " �ɊO�����Ƃɂ���B����Ă����͈Ӑ}�I�ɉ������Ȃ��u���b�N�ɂȂ�B
  endif
  if g:chalice_verbose < 1
    return system(extcmd)
  elseif g:chalice_verbose < 2
    call AL_execute(':!' . escape(extcmd, '%#'))
  else
    execute ':!' . escape(extcmd, '%#')
  endif
endfunction

"
" ���݂̃J�[�\���s�̃X���b�h���J��
"
function! s:OpenThread(...)
  let flag = (a:0 > 0) ? a:1 : 'internal'
  if AL_hasflag(flag, 'firstline')
    " �O���u���E�U�ɂ�firstline���Ƃ���������Ȃ��Ƃ����T�O���Ȃ�����A
    " firstline�w�莞�͈Â�internal�Ƃ��Ĉ����ėǂ��B
    let flag = flag . ',internal'
  endif

  let curline = getline('.')
  let mx2 = '\(http://'.g:AL_pattern_class_url.'\+\)'

  if curline =~ s:mx_thread_dat
    let host = b:host
    let board = b:board
    let title = substitute(curline, s:mx_thread_dat, '\1', '')
    let dat = substitute(curline, s:mx_thread_dat, '\3', '')
    let url = s:GenerateThreadURL(host, board, dat, flag)
  elseif curline =~ mx2
    let url = matchstr(curline, mx2)
  else
    " fold�̊J���g�O��
    silent! normal! 0za
    return
  endif

  " URL�͒��o�ł�����[��]������ꍇ
  if AL_hasflag(flag, 'bookmark') && curline =~ '^\s*'.s:label_board_escaped
    return s:OpenBoard()
  endif

  let retval =  s:HandleURL(url, flag . ',noaddhist')
  if AL_hasflag(flag, 'firstline')
    normal! gg
  endif

  if retval == 1 && !AL_hasflag(flag, 'external')
    call s:AddHistoryJump(s:ScreenLine(), line('.'))
  endif
  " 1�̂ݕ\�����ɃX���ꗗ�ɗ��܂�
  if AL_hasflag(flag, 'firstarticle') && AL_hasflag(g:chalice_previewflags, 'stay')
    call s:GoBuf_ThreadList()
  endif
endfunction

"
" ���݂̃J�[�\���s�ɂ���URL��Ƃ��ĊJ��
"
function! s:OpenBoard(...)
  let board = AL_chomp(getline('.'))
  let mx = '\m^\(.\{-\}\)\s\+\(http://\S*$\)'
  if board !~ mx
    " fold�̊J���g�O��
    normal! 0za
    return 0
  endif
  " �^�C�g����URL�𕪗����o
  let title = AL_sscan(board, mx, '\1')
  let title = substitute(title, '^\s*\('.s:label_board_escaped.'\)\?\s*', '', '')
  let url   = AL_sscan(board, mx, '\2')

  let host = AL_sscan(url, s:mx_url_parse, '\1')
  let path = AL_sscan(url, s:mx_url_parse, '\2')
  let path = substitute(path, '/$', '', '')
  "echo "host=".host." path=".path

  if path =~ '/'
    if host =~ s:mx_servers_shitaraba && path =~ '^bbs/'
      let board = substitute(path, '^bbs', '', '')
    else
      " NOTE: ���d�l�Ή��̂��߂̃��[�N�A���E���h
      let mx = '\m^\(.*\)\(/[^/]\+\)$'
      let host  = host.'/'.AL_sscan(path, mx, '\1')
      let board = AL_sscan(path, mx, '\2')
    endif
  else
    let board = '/'.path
  endif
  "echo "title=" . title . " host=" . host . " board=" . board

  if a:0 > 0 && AL_hasflag(a:1, 'external')
    return s:OpenURL(url)
  endif
  if bufname('%') ==# s:buftitle_boardlist
    call s:HighlightWholeline(line('.'), 'DiffChange')
  endif
  if board ==# '' || board ==# '/'
    " NOTE: �ȊO��URL���J�����߂̎b�胏�[�N�A���E���h�Ȃ̂ŁA�����Ɨǂ���
    " ���ɍ����ւ��������ǂ��B
    call s:HandleURL(url, 'noboardcheck')
  else
    call s:UpdateBoard(title, host, board, '')
  endif
  return 1
endfunction

"
" �^����ꂽURL��2ch���ǂ������f����!!
"
function! s:ParseURL_is2ch(url)
  " �e��URL�p�^�[��
  let mx = '^' . s:mx_url_2channel
  let mx_old = '^\(http://..\{-}/test/read.cgi\)?bbs=\([^&]\+\)&\%(amp\)\?key=\(\d\+\)\(\S\+\)\?'
  let mx_kako = '^\(http://..\{-}\)/\([^/]\+\)/kako/\%(\d\+/\)\{1,2}\(\d\+\)\.\%(html\|dat\%(\.gz\)\?\)'

  " �Â��`����URL�́A���݂̌`���֐��K������(��url)
  let url = ''
  if a:url =~ mx
    let url = a:url
  elseif a:url =~ mx_old
    let url = substitute(a:url, mx_old, '\=submatch(1)."/".submatch(2)."/".submatch(3).s:ConvertOldRange(submatch(4))', '')
  elseif a:url =~ mx_kako
    let url = AL_sscan(a:url, mx_kako, '\1/test/read.cgi/\2/\3')
  endif

  " 2ch-URL�̊e�\���v�f�֕�������
  if url == ''
    return 0
  endif
  let s:parseurl_host = AL_sscan(url, mx, '\1')
  let s:parseurl_board = AL_sscan(url, mx, '\2')
  let s:parseurl_dat = AL_sscan(url, mx, '\3') . '.dat'

  " �\���͈͂�����
  " �Q�l����: http://pc.2ch.net/test/read.cgi/tech/1002820903/
  let range = AL_sscan(url, mx, '\4')
  let mx_range = '[-0-9]\+'
  let s:parseurl_range_mode = ''
  let s:parseurl_range_start = ''
  let s:parseurl_range_end = ''
  let str_range = matchstr(range, mx_range)
  if str_range != ''
    " �͈͕\�L�𑖍�
    let mx_range2 = '\(\d*\)-\(\d*\)'
    if str_range =~ mx_range2
      let s:parseurl_range_start = AL_sscan(str_range, mx_range2, '\1')
      let s:parseurl_range_end	 = AL_sscan(str_range, mx_range2, '\2')
      if s:parseurl_range_start == ''
	let s:parseurl_range_start = 1
      endif
      if s:parseurl_range_end == ''
	let s:parseurl_range_end = '$'
      endif
    else
      " �����������蓾�Ȃ��̂ŉ�
      let s:parseurl_range_start = str_range
      let s:parseurl_range_end = str_range
    endif
    let s:parseurl_range_mode = s:parseurl_range_mode . 'r'
    " �\���t���O(n/l)�̔���
    if range =~ 'n'
      let s:parseurl_range_mode = s:parseurl_range_mode . 'n'
    endif
    if range =~ 'l'
      let s:parseurl_range_mode = s:parseurl_range_mode . 'l'
    endif
  endif

  return 1
endfunction

function! s:ConvertOldRange(range_old)
  " ���`����2ch��URL����A�͈͎w������o��
  if a:range_old == ''
    return ''
  endif

  let mx_range_last = '&\%(amp\)\?ls=\(\d\+\)'
  let mx_range_part = '&\%(amp\)\?st=\(\d\+\)\%(&\%(amp\)\?to=\(\d\+\)\)\?'
  let mx_range_nofirst = '&\%(amp\)\?nofirst=true'

  let range = ''
  if a:range_old =~ mx_range_last
    let range = AL_sscan(a:range_old, mx_range_last, 'l\1')
  elseif a:range_old =~ mx_range_part
    let range = AL_sscan(a:range_old, mx_range_part, '\1-\2')
  endif
  if a:range_old =~ mx_range_nofirst
    let range = range . 'n'
  endif
  return '/'.range
endfunction

"
" �C�ӂ̃o�b�t�@�^�C�g����statusline�ŕ\�����邽�߂̃��b�p�[
"
function! s:GetBufferTitle()
  if !exists('b:title')
    let str = bufname('%')
  else
    let str = b:title
  endif
  return substitute(str, "[\<NL>]\\+", '', 'g')
endfunction

"
" ����s�����Ԗڂ̃X�������肷��
"
function! s:GetArticleNum(lnum)
  let lnum = a:lnum + 0 > 0 ? a:lnum : line(a:lnum)
  while getline(lnum) =~ '^-'
    let lnum = lnum + 1
  endwhile
  while lnum > 0
    let retval = matchstr(getline(lnum), '^\d\+') + 0
    if retval > 0
      return retval
    endif
    let lnum = lnum - 1
  endwhile
  return 0
endfunction

"
" �X���̈ʒu��\������
"
function! s:GetStatus_ThreadNum()
  if exists('b:chalice_lastnum')
    let cur = s:GetArticleNum('.')
    return cur.'/'.b:chalice_lastnum
  else
    return line('.').'/'.line('$')
  endif
endfunction

"
" dat, kako�̗L����\������
"
function! s:GetDatStatus()
  if exists('b:host') && exists('b:board') && exists('b:dat')
    if b:host != '' && b:board != '' && b:dat != ''
      if filereadable(s:GenerateLocalDat(b:host, b:board, b:dat))
	let dat = 'D'
      else
	let dat = '-'
      endif
      if filereadable(s:GenerateLocalKako(b:host, b:board, b:dat))
	let kako = 'K'
      else
	let kako = '-'
      endif
      let bid = substitute(b:board, '^/', '', '')
      if exists('s:movechecked_' . bid) && s:movechecked_{bid} != b:host
	let moved = 'M'
      else
	let moved = '-'
      endif
      return "[" . dat . kako . moved . "]"
    else
      return '[---]'
    endif
  else
    return ''
  endif
endfunction

" s:OpenAllChaliceBuffers
"   Chalice�p�̃o�b�t�@����ʂ�S�ĊJ���Ă��܂�
function! s:OpenAllChaliceBuffers()
  " �X���b�h�p�o�b�t�@���J��
  call AL_execute("edit! " . s:buftitle_thread)
  setlocal filetype=2ch_thread
  let b:title = s:prefix_thread

  " �ꗗ�p�o�b�t�@���J��
  call AL_execute("topleft 15vnew! " . s:buftitle_boardlist)
  setlocal filetype=2ch_boardlist
  let b:title = s:label_boardlist

  " �X���b�h�ꗗ�p�o�b�t�@(==��)���J��
  call s:GoBuf_Thread()
  call AL_execute("leftabove 10new! " . s:buftitle_threadlist)
  setlocal filetype=2ch_threadlist
  let b:title = s:prefix_board
endfunction

function! s:HttpDownload2(uri, filename, continueat, timebase)
  if s:dont_download
    return 200
  endif
  " ���b�Z�[�W�\��
  call s:Redraw('force')
  call s:EchoH('WarningMsg', s:msg_wait_download)
  " �N���I�v�V�����̍\�z��cURL�̎��s
  let opts = g:chalice_curl_options
  " ��dat�ǂݍ��ݐ����ɑΉ�
  let opts = opts.' -A '.AL_quote(s:GetUserAgent())
  if a:continueat > 0
    let opts = opts.' -C '.a:continueat
  endif
  let tmp_head = tempname()
  let opts = opts.' -D '.AL_quote(tmp_head)
  let opts = opts.' -o '.AL_quote(a:filename)
  if filereadable(a:timebase)
    let opts = opts.' -z '.AL_quote(a:timebase)
  endif
  let opts = opts.' '.AL_quote(a:uri)
  " �_�E�����[�h���s
  let cmd = s:cmd_curl.' '.opts
  if s:debug
    let s:last_downloadcommand = cmd
  endif
  call s:DoExternalCommand(cmd)
  " �w�b�_�[���擾���e���|�����t�@�C���폜
  call AL_execute('1vsplit ' . tmp_head)
  let retval = AL_sscan(getline(1), '^HTTP\S*\s\+\(\d\+\).*$', '\1') + 0
  silent! bwipeout!
  call delete(tmp_head)
  " ��ʍĕ`�恨�֐��I��
  call s:Redraw('force')
  return retval
endfunction

" �z�X�g���ƃp�X����URI�𐶐�����
function! s:GenerateHostPathUri(host, path)
  return 'http://'.a:host.'/'.substitute(a:path, '^/\+', '', '')
endfunction

"
" HTTP�_�E�����[�h�̊֐�:
"
" Param:
"   host	�z�X�g���A��������URL
"   remote	�����[�g���Bhost��URL���w�肳�ꂽ�ꍇ�͖��������
"   flag	'', 'noagent', 'continue', 'flag' �܂��͂����̑g�ݍ��킹
" Flags:
"   continue	�p���_�E�����[�h���s�Ȃ�
"   head	�w�b�_�[��񂾂����擾����
"
function! s:HttpDownload(host, remotepath, localpath, flag)
  " �I�t���C���̃`�F�b�N
  if s:dont_download
    return
  endif
  call s:Redraw('force')
  call s:EchoH('WarningMsg', s:msg_wait_download)

  let local = a:localpath
  if a:host =~ s:mx_anchor_url
    let url = a:host
  else
    let url = s:GenerateHostPathUri(a:host, a:remotepath)
  endif
  let continued = 0
  let compressed = 0

  " �N���I�v�V�����̍\�z��cURL�̎��s
  let opts = g:chalice_curl_options

  " ��dat�ǂݍ��ݐ����ɑΉ�
  if s:user_agent_enable && !AL_hasflag(a:flag, 'noagent')
    let opts = opts . ' -A ' . AL_quote(s:GetUserAgent())
  endif

  " �t�@�C���ɍX�V�����鎞�����A���ۂ̓]�������݂�(If-Modified-Since)
  "if filereadable(local) && (AL_hasflag(a:flag, 'continue') || !AL_hasflag(a:flag, 'force'))
  "  let opts = opts . ' -z ' . AL_quote(local)
  "endif
  " MEMO: �{���ɗv��̂�?

  " �p�����[�h�̃I�v�V�����ݒ�
  if AL_hasflag(a:flag, 'continue')
    let size = getfsize(local)
    if size > 0
      let continued = 1
      let opts = opts . ' -C ' . size
    endif
  endif

  " ���k���[�h�̃I�v�V�����ݒ�
  if !continued && g:chalice_gzip && s:cmd_gzip != '' && a:remotepath !~ '\.gz$'
    let compressed = 1
    let local = local . '.gz'
    let opts = opts . ' -H Accept-Encoding:gzip,deflate'
  endif

  " �w�b�_�[�����擾���邽�߃e���|�����t�@�C�����g�p
  let tmp_head = tempname()
  if AL_hasflag(a:flag, 'head')
    " �w�b�_�[��񂾂����擾���� (-I �I�v�V����)
    let opts = opts . ' -I'
    let opts = opts . ' -o ' . AL_quote(tmp_head)
  else
    let opts = opts . ' -D ' . AL_quote(tmp_head)
    let opts = opts . ' -o ' . AL_quote(local)
  endif
  let opts = opts . ' ' . AL_quote(url)

  " �_�E�����[�h���s
  let cmd = s:cmd_curl.' '.opts
  if s:debug
    let s:last_downloadcommand = cmd
  endif
  call s:DoExternalCommand(cmd)

  " �w�b�_�[���擾���e���|�����t�@�C���폜
  call AL_execute('1vsplit ' . tmp_head)
  let retval = AL_sscan(getline(1), '^HTTP\S*\s\+\(\d\+\).*$', '\1') + 0
  if compressed
    if search('^\ccontent-encoding:.*gzip', 'w')
      call s:Gunzip(local)
    else
      call rename(local, substitute(local, '\.gz$', '', ''))
    endif
  endif
  silent! bwipeout!
  call delete(tmp_head)

  call s:Redraw('force')
  return retval
endfunction

"
" �ꗗ�̃o�b�t�@���X�V
"
function! s:UpdateBoardList(force)
  call s:GoBuf_BoardList()
  let b:title = s:label_boardlist

  " �l�b�g���[�N����ꗗ�̃f�[�^���擾����
  let local_menu = s:dir_cache . s:menu_localpath
  if s:fcachedir_enabled
    " �ꗗ���`�L���b�V��
    let cacheid = s:menu_localpath.'.'.&encoding.'.txt'
    let fcachedfile = CACHEMAN_update(s:fcachedir, cacheid)
  endif
  " �ꗗ�̓ǂݍ���
  if a:force || !filereadable(local_menu) || localtime() - getftime(local_menu) > g:chalice_reloadinterval_boardlist
    let mx = '^http://\([^/]\+\)/\(.*\)$'
    if exists('g:chalice_menu_url') && g:chalice_menu_url =~ mx
      " �O�����烁�j���[��URL��^����
      let menu_host = AL_sscan(g:chalice_menu_url, mx, '\1')
      let menu_remotepath = AL_sscan(g:chalice_menu_url, mx, '\2')
    else
      " 2ch�̃t���[����ǂݍ����framedata�Ɋi�[
      let local_frame = tempname()
      call s:HttpDownload(s:host, s:remote, local_frame, '')
      call AL_execute('%delete _')
      call AL_execute('read ' . local_frame)
      call AL_execute("%join")
      let framedata = getline('.')
      call AL_execute('%delete _')
      call delete(local_frame)

      " frame�^�O�̉���
      let framedata = AL_sscan(framedata, '^.*\(frame\>[^>]*name="\?menu"\?[^>]*\)>.*$', '\1')
      let mx = '^.*src="\?http://\([^/]\+\)/\([^" ]*\)"\?.*$'
      let menu_host = AL_sscan(framedata, mx, '\1')
      let menu_remotepath = AL_sscan(framedata, mx, '\2')
    endif

    " �Œ���̕ۏ�
    if menu_host == ''
      let menu_host = s:menu_host
      let menu_remotepath = s:menu_remotepath
    endif

    " ���j���[�t�@�C���̓Ǎ�
    call s:HttpDownload(menu_host, menu_remotepath, local_menu, '')

    " �t�H�[�}�b�g�L���b�V�����폜����
    if s:fcachedir_enabled
      call CACHEMAN_clear(s:fcachedir, cacheid)
    endif
  endif

  " �ꗗ�𐮌`�������̓L���b�V����ǂݍ���
  let save_undolevels = &undolevels
  set undolevels=-1
  if s:fcachedir_enabled && filereadable(fcachedfile)
    " �t�H�[�}�b�g�L���b�V����ǂݍ���
    call AL_buffer_clear()
    call AL_execute('read ++enc= ' . escape(fcachedfile, ' '))
    silent! normal! gg"_dd0
  else
    " �ꗗ�̐��`
    call AL_buffer_clear()
    call AL_execute('read ' . local_menu)
    " ���s<BR>��{���̉��s��
    call AL_execute("%s/\\c<br>/\r/g")
    " �J�e�S���Ɣւ̃����N�ȊO������
    call AL_execute('%g!/^\c<[AB]\>/delete _')
    " �J�e�S���𐮌`
    call AL_execute('%s/^<B>\([^<]*\)<\/B>/' . Chalice_foldmark(0) . '\1/')
    " ���𐮌`
    call AL_execute('%s/^<A HREF=\([^ ]*\/\)[^/>]*>\([^<]*\)<\/A>/ \2\t\t\t\t\1')
    " �u2ch�����ē��v���폜�c�{���͂����ƃ`�F�b�N���Ȃ���_�������ǁB
    normal! gg
    call AL_execute("1,/^" . Chalice_foldmark(0) . "/-1delete _")
    if s:fcachedir_enabled
      call AL_write(fcachedfile)
    endif
  endif
  " ���[�U��`�̔ꗗ�̒ǉ�
  let userboardlist = g:chalice_basedir.'/boardlist.txt'
  if filereadable(userboardlist)
    execute '0read '.userboardlist
  endif
  let &undolevels = save_undolevels

  " folding�쐬
  if 1
    silent! normal! gg
    while 1
      call AL_execute('.,/\n\(' . Chalice_foldmark(0) . '\)\@=\|\%$/fold')
      let prev = line('.')
      silent! normal! j
      if prev == line('.')
	break
      endif
    endwhile
  endif

  silent normal! gg
  call AL_del_lastsearch()
endfunction

"
" Chalice�N���m�F
"
function! ChaliceIsRunning()
  return s:opened
endfunction

"}}}

"------------------------------------------------------------------------------
" MOVE AROUND BUFFER {{{
" �o�b�t�@�ړ��p�֐�

function! s:GetLnum_Article(num)
  " �w�肵���ԍ��̋L���̐擪�s�ԍ����擾�B�J�[�\���͈ړ����Ȃ��B
  call s:GoBuf_Thread()
  let oldline = line('.')
  let oldcol = col('.')
  let anumstr = ''.a:num
  if anumstr ==# 'next'
    let lnum = s:GetLnum_Article(s:GetArticleNum('.') + 1)
  elseif anumstr ==# 'prev'
    let lnum = s:GetLnum_Article('current')
    if lnum >= line('.')
      let lnum = s:GetLnum_Article(s:GetArticleNum('.') - 1)
    endif
    " 1(�ŏ��̋L��)�𒴂������̓w�b�_������\��
    if lnum == 0
      let lnum = 1
    endif
  elseif anumstr ==# 'current'
    let lnum = s:GetLnum_Article(s:GetArticleNum('.'))
  else
    " ���͂�����@������
    if anumstr ==# 'input'
      let target = inputdialog(s:msg_prompt_articlenumber)
    else
      let target = a:num + 0
    endif
    " �ԍ�����L���̈ʒu�𒲂ׂ�
    let lnum = target <= 0 ? 0 : search('^' . target . '  ', 'bw')
  endif
  call cursor(oldline, oldcol)
  return lnum
endfunction

function! s:GoThread_Article(target)
  let lnum = s:GetLnum_Article(a:target)
  if lnum
    if a:target ==# 'input'
      call s:AddHistoryJump(s:ScreenLine(), line('.'))
    endif

    " �w��s�ֈړ�
    call AL_execute("normal! ".lnum."G")
    " �K�v�Ȃ��folding������
    if foldclosed(lnum) > 0
      normal! zO
    endif
    " �\���ʒu���C��
    call AL_execute("normal! zt\<C-Y>")

    if a:target ==# 'input'
      call s:AddHistoryJump(s:ScreenLine(), line('.'))
    endif
  endif
  return lnum
endfunction

function! s:GoBuf_Write()
  let retval = AL_selectwindow(s:buftitle_write)
  if retval < 0
    call AL_execute("rightbelow split " . s:buftitle_write)
    setlocal filetype=2ch_write
  endif
  return retval
endfunction

function! s:GoBuf_Preview()
  let retval = AL_selectwindow(s:buftitle_preview)
  return retval
endfunction

function! s:GoBuf_Thread()
  let retval = AL_selectwindow(s:buftitle_thread)
  return retval
endfunction

function! s:GoBuf_BoardList()
  let retval = AL_selectwindow(s:buftitle_boardlist)
  return retval
endfunction

function! s:GoBuf_ThreadList()
  let retval = AL_selectwindow(s:buftitle_threadlist)
  return retval
endfunction

"}}}

"------------------------------------------------------------------------------
" JUMPLIST {{{
" �Ǝ��̃W�����v���X�g

let s:jumplist_current = 0
let s:jumplist_max = 0

function! s:JumplistClear()
  let s:jumplist_current = 0
  let s:jumplist_max = 0
endfunction

function! s:JumplistCurrent()
  return s:jumplist_max > 0 ? s:jumplist_data_{s:jumplist_current} : -1
endfunction

function! s:JumplistAdd(data)
  if s:jumplist_max > 0
    let s:jumplist_current = s:jumplist_current + 1
  else
    let s:jumplist_current = 0
  endif
  let s:jumplist_data_{s:jumplist_current} = a:data
  let s:jumplist_max = s:jumplist_current + 1

  " ���������������Ȃ��悤�ɐ���
  if s:jumplist_max > g:chalice_jumpmax
    let newmax = g:chalice_jumpmax / 2
    let src = s:jumplist_max - newmax
    let dest = 0
    while dest < newmax
      let s:jumplist_data_{dest} = s:jumplist_data_{src}
      let src = src + 1
      let dest = dest + 1
    endwhile
    let s:jumplist_max = newmax
    let s:jumplist_current = newmax - 1
  endif
endfunction

" �Ō�̗v�f���폜
function! s:JumplistRemoveLast()
  if s:jumplist_max > 0
    let s:jumplist_max = s:jumplist_max - 1
    if s:jumplist_max <= s:jumplist_current
      let s:jumplist_current = s:jumplist_max - 1
      if s:jumplist_current < 0
	let s:jumplist_current = 0
      endif
    endif
  endif
endfunction

function! s:JumplistNext()
  if s:jumplist_current >= s:jumplist_max - 1
    let s:jumplist_current = s:jumplist_max - 1
    return -1
  endif
  let s:jumplist_current = s:jumplist_current + 1
  let retval = s:jumplist_data_{s:jumplist_current}
  return retval
endfunction

function! s:JumplistPrev()
  if s:jumplist_max <= 0 || s:jumplist_current <= 0
    let s:jumplist_current = 0
    return -1
  endif
  let s:jumplist_current = s:jumplist_current - 1
  let retval = s:jumplist_data_{s:jumplist_current}
  return retval
endfunction

" �_���v
function! s:JumplistDump()
  let i = 0
  call s:EchoH('Title',  'Chalice Jumplist (size=' . s:jumplist_max . ')')
  while i < s:jumplist_max
    let padding = i == s:jumplist_current ? '---->' : '     '
    let numstr = matchstr(padding . i, '......$')
    let indicator = (i == s:jumplist_current) ? ' > ' : '  '
    echo numstr . ': ' . s:jumplist_data_{i}
    let i = i + 1
  endwhile
endfunction

"
" �Ǝ��W�����v���X�g�̃f�o�b�O�p�R�}���h
"
if s:debug
  command! JumplistClear		call <SID>JumplistClear()
  command! -nargs=1 JumplistAdd		call <SID>JumplistAdd(<q-args>)
  command! JumplistPrev			echo "Prev: " . <SID>JumplistPrev()
  command! JumplistNext			echo "Next: " . <SID>JumplistNext()
  command! JumplistDump			call <SID>JumplistDump()
endif

"
" �W�����v�����ɍ��ڂ�ǉ�
"
function! s:AddHistoryJump(scline, curline)
  call s:GoBuf_Thread()
  if b:host == '' || b:board == '' || b:dat == ''
    return ''
  endif
  let str1 = b:host.' '.b:board.' '.b:dat.' '.a:scline.' '
  let str2 = str1.a:curline.' '
  let current = s:JumplistCurrent()
  if strpart(current, 0, strlen(str2)) !=# str2
    if strpart(current, 0, strlen(str1)) ==# str1
      call s:JumplistPrev()
    endif
    call s:JumplistAdd(str2.b:title_raw)
    return 1
  else
    return 0
  endif
endfunction

"
" �������W�����v
function! s:DoHistoryJump(flag)
  let data = 0
  if AL_hasflag(a:flag, '\cnext')
    let data = s:JumplistNext()
  elseif AL_hasflag(a:flag, '\cprev')
    let data = s:JumplistPrev()
  endif

  let mx = '^\(\S\+\) \(\S\+\) \(\S\+\) \(\S\+\) \(\S\+\).*$'
  if data =~ mx
    " �����f�[�^������
    let host = AL_sscan(data, mx, '\1')
    let board = AL_sscan(data, mx, '\2')
    let dat = AL_sscan(data, mx, '\3')
    let scline = AL_sscan(data, mx, '\4')
    let curline = AL_sscan(data, mx, '\5')
    " �����ɂ��킹�ăo�b�t�@���ړ�
    call s:GoBuf_Thread()
    if host != b:host || board != b:board || dat != b:dat
      call s:UpdateThread('', host, board, dat, 'continue,noforce')
    endif
    " �X�N���[���\���J�n�s��ݒ聨���s
    call s:ScreenLineJump(scline, 0)
    call AL_execute('normal! ' . curline . 'G')
  endif
endfunction

"}}}

"------------------------------------------------------------------------------
" PREVIEW FUNCTIONS {{{

function! s:OpenPreview_autocmd()
  if g:chalice_preview
    call s:OpenPreview()
  endif
endfunction

"
" �J�[�\�������̃A���J�[���v���r���[���ŊJ��
"
function! s:OpenPreview(...)
  " ���ݍs�̃A���J�[�̌��o
  let anchor = a:0 > 0 && a:1 != '' ? a:1 : s:GetAnchorCurline()
  if anchor =~ s:mx_anchor_num
    " �A���J�[�����X�ԍ��Q�Ƃ̏ꍇ
    let host  = b:host
    let board = b:board
    let dat   = b:dat
  elseif s:ParseURL(anchor)
    " �A���J�[���L����URL�̏ꍇ
    let host  = s:parseurl_host
    let board = s:parseurl_board
    let dat   = s:parseurl_dat
    let anchor = '1'
    if s:parseurl_range_mode !~ 'l'
      if s:parseurl_range_start != ''
	let anchor = s:parseurl_range_start
      endif
      " >>1-1 �� >>1-$ �̂悤�ȕ\�L�������B���Ȃ݂Ɂu>>1-$�v�Ƃ�������1��
      " ��Ō�܂ŕ\������̂ł͂Ȃ��A1�̋L��������\�����Ă���B�v���r���[
      " �̈Ӗ������炻�̂ق����ǂ��Ɣ��f�����̂��낤�B
      if s:parseurl_range_end != '' && anchor != s:parseurl_range_end && s:parseurl_range_end != '$'
	let anchor = anchor.'-'.s:parseurl_range_end
      endif
    endif
    let anchor = '>>'.anchor
  else
    " �A���J�[���Ȃ���Ή������Ȃ����v���r���[�����
    if AL_hasflag(g:chalice_previewflags, 'autoclose')
      call s:ClosePreview()
    endif
    return 0
  endif

  " �A���J�[��dat������Ō�ɕ\�������v���r���[�����ʂ��A�����Ȃ�\�����Ȃ�
  let id = s:GenerateDatname(host, board, dat) . anchor
  if id == getbufvar(s:buftitle_preview, 'chalice_preview_id')
    return 0
  endif

  " �A���J�[����J�n�L���ƏI���L���̔ԍ����擾���A�s�ԍ��֕ϊ�
  let startnum = AL_sscan(anchor, s:mx_anchor_num, '\2') + 0
  let endnum = AL_sscan(anchor, s:mx_anchor_num, '\3') + 0
  if startnum > endnum
    let endnum = startnum
  endif

  let oldbuf = bufname('%')
  let result = s:OpenPreview2(host, board, dat, startnum, endnum)

  if result == 0
    if AL_hasflag(g:chalice_previewflags, 'autoclose')
      call s:ClosePreview()
    endif
    if AL_selectwindow(oldbuf) < 0
      call GoBuf_Thread()
    endif
    return 0
  endif

  " �v���r���[�o�b�t�@�̑̍ق𐮂���
  call setbufvar(s:buftitle_preview, 'chalice_preview_id', id)
  let b:title = s:prefix_preview.anchor
  if host != getbufvar(s:buftitle_thread, 'host') || board != getbufvar(s:buftitle_thread, 'board') || dat != getbufvar(s:buftitle_thread, 'dat')
    let b:title = b:title.' ('.substitute(getline(1), '^Title: ', '', '').')'
  endif
  let b:host  = host
  let b:board = board
  let b:dat   = dat
  call append(1, 'URL: '.s:GenerateThreadURL(host, board, dat, 'raw'))

  " �v���r���[�̍����A�\���ʒu�𒲐߂���B
  call AL_setwinheight(&previewheight)
  normal! 4GztL$
  let height = winline()
  if height < &previewheight
    call AL_setwinheight(height)
  endif
  normal! 4Gzt

  call AL_selectwindow(oldbuf)
  return result
endfunction

" �w�肳�ꂽdat�̎w�肳�ꂽ�͈͂̋L�����v���r���[�\������
function! s:OpenPreview2(host, board, dat, nstart, nend)
  let local = s:GenerateDatname(a:host, a:board, a:dat)
  if !filereadable(local)
    " DAT�������ꍇ�A
    call s:EchoH('ErrorMsg', s:msg_error_cantpreview)
    return 0
  endif

  if s:CountLines(local) < a:nstart
    let retval = s:DatCatchup(a:host, a:board, a:dat, 'continue,ifmodified')
    if retval < 1 || s:CountLines(local) < a:nstart
      call s:EchoH('ErrorMsg', s:msg_error_invalidanchor)
      return 0
    endif
  endif

  " �v���r���[�o�b�t�@�ֈړ��A�K�v�Ȃ�쐬���Ă���ړ�
  if s:GoBuf_Preview() < 0
    let dir = AL_hasflag(g:chalice_previewflags, 'above') ? 'aboveleft' : 'belowright'
    call AL_execute(dir.' pedit '.s:buftitle_preview)
    call s:GoBuf_Preview() " ���s������?�c�m���!!
    setlocal filetype=2ch_thread
  endif

  " �v���r���[�̒��g���쐬����
  let contents = s:FormatThreadPartial(local, a:nstart, a:nend, s:GetHostEncoding(a:host))
  call s:GoBuf_Preview()
  if contents.'X' == 'X'
    call s:EchoH('ErrorMsg', s:msg_error_invalidanchor)
    return 0
  else
    call AL_buffer_clear()
    normal! G$
    call AL_append_multilines(contents)
    normal! gg"_2dd
    call append(0, 'Title: '.s:formatthreadpartion_title)
    return 1
  endif
endfunction

function! s:ClosePreview()
  call AL_execute('pclose')
endfunction

function! s:TogglePreview()
  if g:chalice_preview
    let g:chalice_preview = 0
    call s:ClosePreview()
  else
    let g:chalice_preview = 1
  endif
  " �v���r���[���[�h�\��
  call s:EchoH('WarningMsg', g:chalice_preview ? s:msg_warn_preview_on : s:msg_warn_preview_off)
endfunction

"}}}

"------------------------------------------------------------------------------
" 2HTML {{{
" HTML��
"

function! s:ShowWithHtml(...)
  call s:GoBuf_Thread()
  if !exists("b:host") || !exists("b:board") || !exists("b:dat")
    call s:EchoH('Error', s:msg_error_htmlnotopen)
    return 0
  endif
  let dat = s:GenerateLocalKako(b:host, b:board, b:dat)
  if !filereadable(dat)
    let dat = s:GenerateLocalDat(b:host, b:board, b:dat)
    if !filereadable(dat)
      call s:EchoH('Error', s:msg_error_htmlnodat)
      return 0
    endif
  endif

  " HTML���J�n�L���ԍ��ƏI���L���ԍ����擾
  if a:0 == 0
    let startnum = s:GetArticleNum('.')
    let endnum   = startnum
  elseif a:0 == 1
    let mx = '^\(\d*\)-\(\d*\)$'
    if a:1 =~ mx
      let startnum = AL_sscan(a:1, mx, '\1')
      let endnum   = AL_sscan(a:1, mx, '\2')
    else
      let startnum = a:1
      let endnum   = startnum
    endif
  else
    let startnum = a:1
    let endnum   = a:2
  endif
  let startnum = startnum == '' ? s:GetArticleNum('.') : startnum + 0
  let endnum   =   endnum == '' ? s:GetArticleNum('$') : endnum   + 0

  let url_base  = s:GenerateThreadURL(b:host, b:board, b:dat, 'raw')
  let url_board = s:GenerateBoardURL(b:host, b:board)

  let html = Dat2HTML(dat, startnum, endnum, url_base, url_board)
  if html != ''
    " �t�@�C���֏����o��
    let temp = s:dir_cache.'tmp.html'
    call AL_execute('redir! > '.temp)
    silent echo html
    redir END
    return AL_open_url('file://'.temp, g:chalice_exbrowser)
  else
    " �ʏ�͋N����Ȃ��G���[
    call s:EchoH('Error', 'Something wrong with Dat2HTML()!!')
    return 0
  endif
endfunction

"}}}

"------------------------------------------------------------------------------
" BOOKMARK FUNCTIONS {{{
" Bookmark���[�`��
"
let s:opened_bookmark = 0

"
" �X���ꗗ�̓��e���폜���A�u�b�N�}�[�N���t�@�C������ǂݍ��ݕ\������B
"
function! s:OpenBookmark()
  if s:opened_bookmark
    return
  endif
  call s:GoBuf_ThreadList()
  let s:opened_bookmark = line('.') ? line('.') : 1
  let b:title = s:label_bookmark

  " �x�f�[�^�̓Ǎ���
  let save_undolevels = &undolevels
  set undolevels=-1
  call AL_buffer_clear()
  setlocal filetype=2ch_bookmark
  call AL_execute("read ++enc= " . g:chalice_bookmark)
  silent! normal! gg"_dd0
  let &undolevels = save_undolevels

  call s:Redraw('force')
  call s:EchoH('WarningMsg', s:msg_warn_bookmark)
endfunction

"
" �u�b�N�}�[�N���t�@�C���ɕۑ����A�o�b�t�@����������B
"
function! s:CloseBookmark()
  if !s:opened_bookmark
    return
  endif
  let s:opened_bookmark = 0
  call s:GoBuf_ThreadList()
  match none
  " �u�b�N�}�[�N�̃o�b�N�A�b�v�t�@�C���l�[�����쐬
  let mx = escape(s:bookmark_filename, '.').'$'
  let backupname = g:chalice_bookmark . s:bookmark_backupsuffix
  if g:chalice_bookmark =~ mx
    let backupname = substitute(g:chalice_bookmark, mx, s:bookmark_backupname, '')
  endif
  " �o�b�N�A�b�v�t�@�C�����[���Â���΍ēx�o�b�N�A�b�v���s�Ȃ�
  if g:chalice_bookmark_backupinterval >= s:minimum_backupinterval && localtime() - getftime(backupname) > g:chalice_bookmark_backupinterval
    call rename(g:chalice_bookmark, backupname)
  endif
  " �u�b�N�}�[�N�t�@�C����ۑ�
  call AL_write(g:chalice_bookmark)
  let save_undolevels = &undolevels
  set undolevels=-1
  call AL_buffer_clear()
  let &undolevels = save_undolevels

  " ft���Z�b�g�����u�ԂɕK�v�ȃo�b�t�@�ϐ�����������Ă��܂��̂ŁA���̑΍�B
  " ���������o�b�t�@�ϐ��� ftplugin/2ch_threadlist.vim �Q��:
  "	b:title, b:title_raw, b:host, b:board
  let title_raw = b:title_raw
  let host = b:host
  let board = b:board
  setlocal filetype=2ch_threadlist
  let b:title_raw = title_raw
  let b:host = host
  let b:board = board
endfunction

function! s:AddBookmark(title, url)
  let winnum = winnr()
  call s:OpenBookmark()
  call s:GoBuf_ThreadList()
  let url = a:url

  " 2�d�o�^��
  normal! gg
  let existedbookmark = search('\V'.escape(a:url, "\\"), 'w')
  normal! 0
  if existedbookmark
    " �o�^���悤�Ƃ��Ă���URL�����o�̏ꍇ�A����URL��\�����Ăǂ����ׂ����₢
    " ���킹��B
    if foldclosed(existedbookmark) > 0
      " current��existedbookmark�������ł���ƌ����O��(����search�ɂ��ۏ�
      " ����Ă���)
      normal! zv
    endif
    normal! 0zz
    " �₢���킹
    call s:HighlightWholeline(existedbookmark, 'Search')
    call s:Redraw('force')
    let last_confirm = confirm(s:msg_confirm_replacebookmark, s:choice_rac, 3, "Question")
    match none
    call s:Redraw('force')
    if last_confirm == 1
      " �u������
      call AL_execute(':' . existedbookmark . 'delete _')
    elseif last_confirm == 2
      " �����ǉ�
    elseif last_confirm == 3
      " �o�^���L�����Z��
      let url = ''
    endif
  endif

  " URL���o�b�t�@�ɏ�����
  if url != ''
    call append(0, a:title . "\t\t\t\t" . url)
  endif

  execute winnum.'wincmd w'
  if url == ''
    call s:Redraw('force')
    call s:EchoH('WarningMsg', s:msg_warn_bmkcancel)
  endif
endfunction

function! s:ToggleBookmark(flag)
  if !s:opened_bookmark
    call s:OpenBookmark()
  else
    let lnum = s:opened_bookmark
    call s:UpdateBoard('', '', '', '')
    call s:GoBuf_ThreadList()
    execute "normal! " . lnum . "G0"
  endif
  if AL_hasflag(a:flag, 'thread')
    call s:GoBuf_Thread()
  elseif AL_hasflag(a:flag, 'threadlist')
    call s:GoBuf_ThreadList()
  endif
endfunction

function! s:Thread2Bookmark(target)
  let title = ''
  let url = ''
  if AL_hasflag(a:target, 'thread')
    " �X���b�h����x�ɓo�^
    call s:GoBuf_Thread()
    if b:host == '' || b:board == '' || b:dat == ''
      call s:Redraw('force')
      call s:EchoH('ErrorMsg', s:msg_error_addnothread)
      return
    endif
    if b:title_raw == ''
      let title = b:host . b:board . '/' . b:dat
    else
      let title = b:title_raw
    endif
    let url = s:GenerateThreadURL(b:host, b:board, b:dat, 'internal')
  elseif AL_hasflag(a:target, 'threadlist')
    " �X���ꗗ����x�ɓo�^
    call s:GoBuf_ThreadList()
    let curline = getline('.')
    let mx = '^. \(.\+\) (\d\+) \%(\d\d\d\d\/\d\d\/\d\d \d\d:\d\d:\d\d\)\?\s*\(\d\+\)\.\%(dat\|cgi\)$'
    if b:host == '' || b:board == '' || curline !~ s:mx_thread_dat
      call s:Redraw('force')
      call s:EchoH('ErrorMsg', s:msg_error_addnothreadlist)
      return
    endif
    let title = AL_sscan(curline, s:mx_thread_dat, '\1')
    let dat = AL_sscan(curline, s:mx_thread_dat, '\3')
    let url = s:GenerateThreadURL(b:host, b:board, dat, 'internal')
  elseif AL_hasflag(a:target, 'boardlist')
    " �ꗗ����x�ɓo�^
    call s:GoBuf_BoardList()
    let curline = getline('.')
    let mx = '^ \(.\+\)\s\+\(http:.\+\)$'
    if curline !~ mx
      call s:Redraw('force')
      call s:EchoH('ErrorMsg', s:msg_error_addnoboardlist)
      return
    endif
    " [��]��t���邱�ƂŃX���b�h�̋��(�X������[��]�Ŏn�܂����狃��?)
    let title = s:label_board.' '.AL_sscan(curline, mx, '\1')
    let url = AL_sscan(curline, mx, '\2')
  endif
  " OUT: title��url

  call s:Redraw('force')
  if 0
    echo "title=" . title . " url=" . url
  else
    call s:AddBookmark(title, url)
  endif
endfunction

"}}}

"------------------------------------------------------------------------------
" WRITE BUFFER {{{
" �������݃o�b�t�@���[�`��
"

" �Ō�̏������݂Ŏg�p����username�y��usermail
let s:last_username = ''
let s:last_usermail = ''

" �J�����g�o�b�t�@����
" <input type=hidden>��name��value��URL�`���Ŏ擾����
function! s:GetHiddenInputAsParamsFromBuffer(name_allow, name_deny)
  let retval = ''
  let mx = '\m\c<input type="\?hidden"\? name="\?\([^" \t>]*\)"\? value="\?\([^" \t>]*\)"\?'
  call AL_execute('%s/'.mx.'/\r&/g')
  call AL_execute('v/'.mx.'/d _')
  let lnum = 1
  while lnum <= line('$')
    let lstr = getline(lnum)
    let lnum = lnum + 1
    let name  = AL_sscan(lstr, mx, '\1')
    let value = AL_sscan(lstr, mx, '\2')
    if name != '' && (a:name_allow == '' || name =~ a:name_allow) && (a:name_deny == '' || name !~ a:name_deny)
      let retval = retval . '&'.name.'='.value
    endif
  endwhile
  call AL_execute('undo')
  call AL_execute('undo')
  return retval
endfunction

" URL�̃R���e���c����
" <input type=hidden>��name��value��URL�`���Ŏ擾����
function! s:GetHiddenInputAsParams(url)
  let tmp = tempname()
  call s:HttpDownload(a:url, '', tmp, '')
  call AL_execute('1vsplit ++enc= '.tmp)
  call delete(tmp)
  let retval = s:GetHiddenInputAsParamsFromBuffer('', '')
  silent! bwipeout!
  return retval
endfunction

function! s:GetWriteParams(url, host, bbs, key)
  " 2ch����A�������݂ɕK�v��hidden�p�����[�^���擾����
  let params = s:GetHiddenInputAsParams(s:GenerateThreadURL(a:host, a:bbs, a:key, 'onlyone'))
  if params != ''
    return params
  else
    if a:host =~ s:mx_servers_jbbstype
      return '&BBS='.a:bbs.'&KEY='.a:key.'&TIME='.localtime()
    else
      return '&bbs='.a:bbs.'&key='.a:key.'&time='.localtime()
    endif
  endif
endfunction

"
" �������ݗp�o�b�t�@���J��
"
function! s:OpenWriteBuffer(...)
  let newthread = 0
  let quoted = ''

  " �X���b�h�o�b�t�@���� host, board, dat ���擾
  if !newthread
    " �ʏ�̏�������
    call s:GoBuf_Thread()
    if b:host == '' || b:board == '' || b:dat == ''
      call s:EchoH('ErrorMsg', s:msg_error_appendnothread)
      return 0
    endif
    let title = b:title_raw
    let key = substitute(b:dat, '\.\(dat\|cgi\)$', '', '')
    " ���݃J�[�\��������L���̈��p
    if a:0 > 0 && AL_hasflag(a:1, 'quote')
      " ���p�J�n�ʒu������
      let quote_start = s:GetLnum_Article('current') - 1
      let first_article = s:GetLnum_Article(1) - 1
      if quote_start < first_article
	let quote_start = first_article
	let quote_end = s:GetLnum_Article(2) - 3
      else
	" ���p�I���ʒu������
	let quote_end = s:GetLnum_Article('next') - 3
      endif
      " �͈͎w�肪�Ђ�����Ԃ��Ă��鎞�A�������͕s���Ȏ�
      if quote_end < 1 || quote_end < quote_start
	let quote_end = line("$")
      endif
      " ���͂����p������������쐬(->quoted�Ɋi�[)
      let quoted = '>>' . matchstr(getline(quote_start + 1), '^\(\d\+\)')
      let i = quote_start + 2
      while i <= quote_end
	let quoted = AL_addline(quoted, substitute(getline(i), '^.', '>', ''))
	let i = i + 1
      endwhile
    endif
  else
    " TODO �V�K��������
    call s:GoBuf_ThreadList()
    if b:host == '' || b:board == ''
      call s:EchoH('ErrorMsg', s:msg_error_creatnoboard)
      return 0
    endif
    let title = ''
    let key = localtime()
  endif
  let host = b:host
  let bbs = substitute(b:board, '^/', '', '')

  " �t���O�ɉ����ē����Asage�������ݒ�
  if exists('g:chalice_username_'.bbs.'_'.key)
    let username = g:chalice_username_{bbs}_{key}
  elseif exists('g:chalice_username_'.bbs)
    let username = g:chalice_username_{bbs}
  else
    let username = g:chalice_username
  endif
  if exists('g:chalice_usermail_'.bbs.'_'.key)
    let usermail = g:chalice_usermail_{bbs}_{key}
  elseif exists('g:chalice_usermail_'.bbs)
    let usermail = g:chalice_usermail_{bbs}
  else
    let usermail = g:chalice_usermail
  endif
  if a:0 > 0
    if AL_hasflag(a:1, 'anony')
      let username = g:chalice_anonyname
      let usermail = ''
    endif
    if AL_hasflag(a:1, 'last')
      let username = s:last_username
      let usermail = s:last_usermail
    endif
    if AL_hasflag(a:1, 'sage')
      let usermail = 'sage'
    endif
    if AL_hasflag(a:1, 'new')
      let newthread = 1
    endif
  endif

  " �o�b�t�@�̍쐬
  call s:GoBuf_Write()
  if !newthread
    let b:title = s:prefix_write . title
  else
    let b:title = s:prefix_write . s:label_newthread
  endif
  let b:title_raw = title
  let b:host = host
  let b:bbs = bbs
  let b:key = key
  let b:newthread = newthread
  " �������ނׂ��X����URL���쐬���o�b�t�@�ϐ��ɕۑ�����
  let b:url = 'http://'.host.'/test/read.cgi/'.bbs.'/'.key
  " hidden��time�p�����[�^�̐������A�������ݎ��ł͂Ȃ��o�b�t�@�쐬���ɂ���
  let b:write_params = s:GetWriteParams(b:url, host, bbs, key)

  call s:Redraw('')

  " �������݃e���v���[�g�쐬
  let save_undolevels = &undolevels
  set undolevels=-1
  call AL_buffer_clear()
  let def = AL_addline('', 'Title: ' . title)
  let def = AL_addline(def, 'From: ' . username)
  let def = AL_addline(def, 'Mail: ' . usermail)
  let def = AL_addline(def, '--------')
  if quoted.'X' != 'X'
    let def = AL_addline(def, quoted)
  endif
  let def = AL_addline(def, '')
  call AL_append_multilines(def)
  let s:opened_write = 1
  let &undolevels = save_undolevels
  let &modified = 0

  " �������݂Ɏ��s�������͂�����Ύ����I�ɒǉ��B
  " �Ȃ���΃C���T�[�g���[�h�J�n�B
  if exists('g:chalice_lastmessage') && g:chalice_lastmessage != ''
    normal! G$
    call AL_append_multilines(g:chalice_lastmessage)
    call s:Redraw('force')
    call s:EchoH('WarningMsg', s:msg_help_rewrite)
  else
    call s:Redraw('force')
    call s:EchoH('WarningMsg', s:msg_help_write)
    normal! G
    startinsert
  endif
endfunction

function! s:OnCloseWriteBuffer()
  let s:opened_write = 0
endfunction

"
" ��������!!�B�������ݓ��e�����������`�F�b�N���Ă��珑�����݁B
"
function! s:DoWriteBuffer(flag)
  if !s:opened_write
    return 0
  endif
  call s:GoBuf_Write()
  let newthread = b:newthread
  " �������ݎ��s
  let write_result =  s:DoWriteBufferStub(a:flag)

  " �������݂ɐ����������ɂ͍ŏI���b�Z�[�W���N���A����
  if write_result != 0
    let g:chalice_lastmessage = ''
  endif

  " �������݌�̃o�b�t�@����
  if AL_hasflag(a:flag, '\cclosing')
    let s:opened_write = 0
    call s:GoBuf_Thread()
  elseif write_result != 0
    let s:opened_write = 0
    call s:GoBuf_Write()
    execute ":close!"
    call s:GoBuf_Thread()
  endif

  if !s:opened_write
    if !newthread
      "call s:GoBuf_Thread()
      "normal! zb
    else
      " �V�X���쐬��(���݂͎g���Ȃ�)
      call s:GoBuf_ThreadList()
    endif
  endif
  return 1
endfunction

" �������݂����s����B���������ꍇ��0�ȊO��Ԃ��B
" TODO: �߂�l�͍l���������ق����ǂ��B-1�Ƃ��ςȒl���Ԃ��Ă���B
function! s:DoWriteBufferStub(flag)
  let force_close = AL_hasflag(a:flag, '\cclosing')
  let writeoptions = g:chalice_writeoptions
  call s:GoBuf_Write()
  call s:Redraw('force')
  let newthread = b:newthread

  " �f�o�b�O�\��
  if 0
    echo 'b:title_raw=' . b:title_raw
    echo 'b:host=' . b:host
    echo 'b:bbs=' . b:bbs
    echo 'b:key=' . b:key
  endif

  " �������݃o�b�t�@�w�b�_�̑Ó�������
  let title = getline(1)
  let name = getline(2)
  let mail = getline(3)
  let sep = getline(4)
  if title !~ '^Title:\s*' || name !~ '^From:\s*' || mail !~ '^Mail:\s*' || sep != '--------'
    call confirm(s:msg_error_writebufhead, "", 1, "Error")
    return 0
  endif
  let title = AL_chompex(substitute(title,  '^Title:', '', ''))
  let name =  AL_chompex(substitute(name,   '^From:',  '', ''))
  let mail =  AL_chompex(substitute(mail,   '^Mail:',  '', ''))

  " �V�X���쐬���Ƀ^�C�g����ݒ肵�����m�F
  if newthread && title == ''
    call confirm(s:msg_error_writetitle, "", 1, "Error")
    return 0
  endif

  if !AL_hasflag(writeoptions, 'keepemptylines')
    " �{���擪�Ɩ����̋󔒍s���폜
    normal! 5G
    while line('.') > 4
      if getline('.') !~ '^\s*$'
	break
      endif
      normal! "_dd
    endwhile
    " ����
    normal! G
    while line('.') > 4
      if getline('.') !~ '^\s*$'
	break
      endif
      normal! "_dd
    endwhile
  endif

  " �{�������邩���`�F�b�N
  if line('$') < 5
    call confirm(s:msg_error_writebufbody, "", 1, "Error")
    return 0
  endif

  " �{�����̃^�u�𐮗�
  if AL_hasflag(writeoptions, 'retab')
    silent! retab!
  endif

  " �{�����烁�b�Z�[�W���擾
  let message = getline(5)
  let curline = 6
  let lastline = line('$')
  while curline <= lastline
    let message = message . "\n" . getline(curline)
    let curline = curline + 1
  endwhile
  let g:chalice_lastmessage = message

  " �K�v�ȕ����͎��̎Q�Ƃ֒u������
  if b:host =~ s:mx_servers_shitaraba
    " ������Όn�ł�&amp;��&nbsp;�ւ̒u�����̓T�[�o���ōs�Ȃ���
    let writeoptions = AL_delflag(writeoptions, 'amp')
    let writeoptions = AL_delflag(writeoptions, 'nbsp')
    let writeoptions = AL_delflag(writeoptions, 'nbsp2')
  endif
  " &�L����&amp;�ɒu��
  if AL_hasflag(writeoptions, 'amp')
    let message = substitute(message, '&', '\&amp;', 'g')
  endif
  " ���p�X�y�[�X2��S�p�X�y�[�X1�ɓW�J
  if AL_hasflag(writeoptions, 'zenkaku')
    let message = substitute(message, '  ', '�@', 'g')
  endif
  " ���p�X�y�[�X��&nbsp;�ɒu��
  if AL_hasflag(writeoptions, 'nbsp')
    let message = substitute(message, ' ', '\&nbsp;', 'g')
  endif
  " &nbsp;�ւ̓W�J���ŏ����ɂ���
  if AL_hasflag(writeoptions, 'nbsp2')
    "let message = substitute(message, '  ', ' \&nbsp;', 'g')
    let message = substitute(message, '\(^\|'."\n".'\| \) ', '\1\&nbsp;', 'g')
  endif

  " �������ݑO�̍Ō�̊m�F
  echohl Question
  " chalice_noquery_write���ݒ肳��Ă��鎞�ɂ͗L�������킳�������ށBChalice
  " �I���ɔ������������݂ł͓��I�v�V�����Ɋւ�炸�m�F������B
  if AL_hasflag(a:flag, 'quit') || !exists('g:chalice_noquery_write') || !g:chalice_noquery_write
    if force_close
      " �ʏ�̊m�F
      let last_confirm = confirm(s:msg_confirm_appendwrite_yn, s:choice_yn, 2, "Question")
      echohl None
      if last_confirm == 1
      elseif last_confirm == 2
	call confirm(s:msg_error_writeabort, "", 1, "Error")
	return -1
      endif
    else
      " �I�����ɃL�����Z��������m�F
      let last_confirm = confirm(s:msg_confirm_appendwrite_ync, s:choice_ync, 3, "Question")
      echohl None
      if last_confirm == 1
      elseif last_confirm == 2
	call s:Redraw('force')
	call s:EchoH('ErrorMsg', s:msg_error_writeabort)
	return -1
      elseif last_confirm == 3
	call s:Redraw('force')
	call s:EchoH('WarningMsg', s:msg_error_writecancel)
	return 0
      endif
    endif
  endif

  " �������݃f�[�^�`�����N�쐬
  let key = b:key
  let flags = ''
  if newthread
    let key = localtime()
    let flags = flags . 'new'
  endif
  let chunk = s:CreateWriteChunk(b:host, b:bbs, key, title, name, mail, message, flags)
  if chunk == ''
    return 0
  endif

  " �������݌��ʂ��i�[����ꎞ�t�@�C��
  let resfile = tempname()
  " �������ޓ��e��ۑ������ꎞ�t�@�C��
  let tmpfile = tempname()
  redraw!
  execute "redir! > " . tmpfile 
  silent echo chunk
  redir END
  if s:debug
    let g:chalice_lastchunk = chunk
  endif

  " �������݃R�}���h�̔��s
  "   �K�v�ȃf�[�^�ϐ�: tmpflie, b:host, b:bbs
  call s:Redraw('force')
  " �N���I�v�V�����̍\�z��cURL�̎��s
  let opts = g:chalice_curl_options
  if exists('g:chalice_curl_writeoptions') && g:chalice_curl_writeoptions.'X' != 'X'
    let opts = g:chalice_curl_writeoptions
  endif
  if s:user_agent_enable
    let opts = opts . ' -A ' . AL_quote(s:GetUserAgent())
  endif
  let opts = opts . ' -b NAME= -b MAIL='
  if g:chalice_curl_cookies != 0 && exists('g:chalice_cookies')
    let opts = opts . ' -c ' . AL_quote(g:chalice_cookies)
    let opts = opts . ' -b ' . AL_quote(g:chalice_cookies)
  endif
  let opts = opts . ' -d @' . AL_quote(tmpfile)
  let opts = opts . ' -e http://' . b:host . '/' . b:bbs . '/index2.html'
  let opts = opts . ' -o ' . AL_quote(resfile)
  let opts = opts . ' ' . s:GenerateWriteURL(b:host, b:bbs, b:key)
  let thread_url = s:GenerateThreadURL(b:host, b:bbs, b:key, 'raw')
  let exec_cmd = s:cmd_curl.' '.opts
  call s:DoExternalCommand(exec_cmd)
  " �������ݎ���username��usermail��ۑ�
  let s:last_username = name
  let s:last_usermail = mail
  let wrote_host = b:host

  " �������݌���(resfile)�̉��
  let retval = 1
  let show_resfile = 0
  let error_msg = ''
  let new_write_params = ''
  call AL_execute('1vsplit '.resfile)
  let mx = '2ch_X:\(\w\+\)'
  let nr2ch_X = search(mx, 'w')
  let rescode = nr2ch_X > 0 ? AL_sscan(getline(nr2ch_X), mx, '\1') : ''
  " �������݂ɂȂ�炩�̗��R�Ŏ��s���Ă�����return 0(retval = 0)����B
  " ���ʃt�@�C����\�����邩�ǂ�����show_resfile�Ő��䂷��B
  " �G���[���b�Z�[�W��\������K�v������ꍇ�ɂ�error_msg�ɐݒ肷��B
  if rescode ==# 'cookie'
    " Cookie�m�F��ʂ�write_params���X�V����B
    let retval = 0
    let show_resfile = 1
    let error_msg = s:msg_error_writecookie
    if wrote_host =~ s:mx_servers_jbbstype
      let new_write_params = s:GetHiddenInputAsParamsFromBuffer('', '\m^\%(SUBJECT\|NAME\|MAIL\|MESSAGE\)$')
    else
      let new_write_params = s:GetHiddenInputAsParamsFromBuffer('', '\m^\%(subject\|FROM\|mail\|MESSAGE\)$')
    endif
  elseif rescode ==# 'error'
    let retval = 0
    let show_resfile = 1
    let error_msg = s:msg_error_writeerror
  elseif rescode ==# 'false'
    let show_resfile = 1
    let error_msg = s:msg_error_writefalse
  elseif rescode ==# 'check'
    let retval = 0
    let show_resfile = 1
    let error_msg = s:msg_error_writecheck
  elseif getline(2) =~ '�T�[�o.*����.*��'
    " �T�[�o�ߕ��ׂɂ�鏑�����ݎ��s
    let retval = 0
    let show_resfile = 1
    let error_msg = s:msg_error_writehighload
  else
    let is_error = 1
    if is_error == 1 && rescode ==? 'true'
      let is_error = 0
    endif
    if is_error == 1 && getline(1) =~ '�������݂܂���'
      let is_error = 0
    endif
    if is_error == 1 && search('<title>�������݂܂����B</title>', 'w') > 0
      let is_error = 0
    endif
    if is_error == 1 && wrote_host =~ s:mx_servers_machibbs && search('302 Found', 'w') > 0
      let is_error = 0
    endif
    if is_error != 0
      " �������ݐ����ł͂Ȃ��ꍇ
      let retval = 0
      let show_resfile = 1
      let error_msg = s:msg_error_writenottrue
    endif
  endif
  " ���ʃt�@�C����HTML�ŕ\��
  if show_resfile
    let temp = s:dir_cache.'tmp.html'
    call AL_write(temp)
    call AL_open_url('file://'.temp, g:chalice_exbrowser)
  endif
  silent! bwipeout!
  " ���݂���ꍇ�ɂ̓G���[���b�Z�[�W��\������
  if error_msg.'X' ==# 'X'
    let result = 'OK'
  else
    let result = 'ERROR: '.error_msg
  endif

  " ���O�����
  if AL_hasflag(g:chalice_writeoptions, 'log')
    call s:LogWriteBuffer(thread_url, exec_cmd, result)
  endif

  if result !=# 'OK'
    call s:Redraw('force')
    call s:EchoH('ErrorMsg', error_msg)
    if new_write_params != ''
      let b:write_params = new_write_params
    endif
  endif

  " ��n��
  call delete(resfile)
  call delete(tmpfile)
  if retval > 0
    if !newthread
      call s:UpdateThread('', '', '', '', 'continue,force')
    else
      call s:UpdateThread(title,  b:host , '/' . b:bbs, b:key . '.dat', '')
    endif
  endif
  return retval
endfunction

function! s:LogWriteBuffer(thread_url, exec_cmd, result)
  call s:GoBuf_Write()
  echo ""
  execute "redir! >> ".s:chalice_writelogfile
  silent echon 'Time: '.strftime('%Y/%m/%d %H:%M:%S')
  silent echo 'Result: '.a:result
  silent echo 'Command: '.a:exec_cmd
  silent echo 'URL: '.a:thread_url
  silent %print
  silent echo AL_string_multiplication('=', 78)
  silent echo ''
  redir END
endfunction

function! s:CreateWriteChunk(host, board, key, title, name, mail, message, ...)
  let flags = a:0 > 0 ? a:1 : ''

  " �z�X�g�ɍ��킹�ăT�u�~�b�g�L�[������
  let sbmk = '��������'
  if AL_hasflag(flags, 'new')
    if a:host =~ s:mx_servers_jbbstype
      let sbmk = '�V�K��������'
    else
      let sbmk = '�V�K�X���b�h�쐬'
    endif
  endif

  " �z�X�g�ɍ��킹�ď������݃G���R�[�f�B���O������
  let enc_write = s:GetHostEncoding(a:host)

  " �����R�[�h�ϊ�
  let title = a:title
  let name = a:name
  let mail = a:mail
  let msg = a:message
  if &encoding != enc_write
    if has('iconv')
      let title	= iconv(title,	&encoding, enc_write)
      let name	= iconv(name,	&encoding, enc_write)
      let mail	= iconv(mail,	&encoding, enc_write)
      let msg	= iconv(msg,	&encoding, enc_write)
      let sbmk	= iconv(sbmk,	&encoding, enc_write)
    else
      " TODO: �G���[���b�Z�[�W
      return ''
    endif
  endif

  " �������ݗp�`�����N�쐬
  let sbmk = AL_urlencode(sbmk)
  if b:host =~ s:mx_servers_jbbstype
    return s:CreateWriteChunk_JBBS(a:host, a:board, a:key, title, name, mail, msg, sbmk, flags)
  else

    return s:CreateWriteChunk_2ch(a:host, a:board, a:key, title, name, mail, msg, sbmk, flags)
  endif
endfunction

function! s:CreateWriteChunk_2ch(host, board, key, title, name, mail, message, submitkey, ...)
  " �������݃f�[�^�`�����N���쐬
  " 2�����˂�A2�����˂�݊��A������Ηp
  "   ���p���ׂ��f�[�^�ϐ�: name, mail, message, a:board, a:key(, host)
  "   �Q�lURL: http://members.jcom.home.ne.jp/monazilla/document/write.html
  let flags = a:0 > 0 ? a:1 : ''
  let chunk = ''
  let chunk = chunk . 'submit=' . a:submitkey
  let chunk = chunk . '&FROM=' . AL_urlencode(a:name)
  let chunk = chunk . '&mail=' . AL_urlencode(a:mail)
  let chunk = chunk . '&MESSAGE=' . AL_urlencode(a:message)
  " bbs��key��b:write_params�Ƃ��āA�擾�ł��Ă���n�Y�Ȃ̂Œǉ����Ȃ�
  "let chunk = chunk . '&bbs=' . a:board
  if !AL_hasflag(flags, 'new')
    "let chunk = chunk . '&key=' . a:key
  else
    let chunk = chunk . '&subject=' . AL_urlencode(a:title)
  endif
  if exists('b:write_params')
    let chunk = chunk . b:write_params
  endif
  " SID������ꍇ�͒ǉ�����
  let chunk = s:AddSidToChunk(chunk)
  return chunk
endfunction

"}}}

"------------------------------------------------------------------------------
" GENERATE FILENAMES {{{
" �t�@�C�����̐���

function! s:GetPath_FormatedCache_Subject(host, board)
  return s:GetPath_FormatedCache(a:host, a:board, 'subject')
endfunction

function! s:GetPath_FormatedCache(host, board, dat)
  return s:RegularlisePath(a:host.a:board).'_'.s:RegularliseDat(a:dat).'.'.&encoding.'.txt'
endfunction

function! s:GetPath_Datdir_Skelton(host, board, dat, ext)
  let hostdir = s:GetPath_Datdir_Host(a:host)
  if hostdir.'X' ==# 'X'
    return ''
  else
    return hostdir.s:RegularlisePath(a:board).'_'.s:RegularliseDat(a:dat).a:ext
  endif
endfunction

function! s:GetPath_Datdir_Dat(host, board, dat)
  return s:GetPath_Datdir_Skelton(a:host, a:board, a:dat, '.dat')
endfunction

function! s:GetPath_Datdir_Kako(host, board, dat)
  return s:GetPath_Datdir_Skelton(a:host, a:board, a:dat, '.kako')
endfunction

function! s:GetPath_Datdir_Abone(host, board, dat)
  return s:GetPath_Datdir_Skelton(a:host, a:board, a:dat, '.abone')
endfunction

function! s:GetPath_Datdir_Subject(host, board)
  return s:GetPath_Datdir_Skelton(a:host, a:board, 'subject', '.txt')
endfunction

" �z�X�g�p��DATDIR�̃p�X��Ԃ��B
function! s:GetPath_Datdir_Host(host)
  return s:GetPath_Datdir().s:RegularlisePath(a:host).'/'
endfunction

" DATDIR�p�f�B���N�g�����擾����B
function! s:GetPath_Datdir()
  return s:dir_cache.'dat.d/'
endfunction

" Chalice�Ŏg�p���郊���[�g�p�X�𐳋K������
function! s:RegularlisePath(path)
  return substitute(substitute(a:path, '/', '_', 'g'), '^_\|_$', '', '')
endfunction

" Chalice�Ŏg�p����DAT���ʎq�̊g���q���폜�A���K������
function! s:RegularliseDat(dat)
  return substitute(a:dat, '\m.\(dat\|cgi\)$', '', '')
endfunction

function! s:GenerateAboneFile(host, board, dat)
  if s:datdir_enabled
    return s:GetPath_Datdir_Abone(a:host, a:board, a:dat)
  else
    return s:dir_cache .'abonedat_'. s:RegularlisePath(a:host.a:board) .'_'. s:RegularliseDat(a:dat)
  endif
endfunction

function! s:GenerateDatname(host, board, dat)
  let datname = s:GenerateLocalKako(a:host, a:board, a:dat)
  if filereadable(datname)
    return datname
  endif
  let datname = s:GenerateLocalDat(a:host, a:board, a:dat)
  if filereadable(datname)
    return datname
  endif
  return ''
endfunction

function! s:GenerateRemoteDat(host, board, dat)
  if a:host =~ s:mx_servers_shitaraba
    return '/bbs'.a:board.'/dat/'.a:dat.'.dat'
  else
    return a:board.'/dat/'.a:dat
  endif
endfunction

" ���[�J��DAT�̃p�X�𐶐�����
function! s:GenerateLocalDat(host, board, dat)
  if s:datdir_enabled
    return s:GetPath_Datdir_Dat(a:host, a:board, a:dat)
  else
    return s:dir_cache .'dat_'. s:RegularlisePath(a:host.a:board) .'_'. s:RegularliseDat(a:dat)
  endif
endfunction

function! s:GenerateLocalKako(host, board, dat)
  if s:datdir_enabled
    return s:GetPath_Datdir_Kako(a:host, a:board, a:dat)
  else
    return s:dir_cache .'kako_dat_'. s:RegularlisePath(a:host.a:board) .'_'. s:RegularliseDat(a:dat)
  endif
endfunction

function! s:GenerateLocalSubject(host, board)
  if s:datdir_enabled
    return s:GetPath_Datdir_Subject(a:host, a:board)
  else
    return s:dir_cache .'subject_'. s:RegularlisePath(a:host.a:board)
  endif
endfunction

"}}}

"------------------------------------------------------------------------------
" FORMATTING {{{
" �e�y�C���̐��`

function! s:WriteFormatedCache_Subject(host, board)
  if s:fcachedir_enabled
    let cacheid = s:GetPath_FormatedCache_Subject(a:host, a:board)
    let fcachedfile = CACHEMAN_update(s:fcachedir, cacheid)
    call AL_write(fcachedfile)
  endif
endfunction

function! s:ShowNumberOfArticle(flags)
  " �X���ꗗ�̊����X�������X�V
  let save_undolevels = &undolevels
  set undolevels=-1
  if AL_hasflag(a:flags, 'all')
    let retval = s:FormatThreadInfo(1, 0, 'numcheck')
  elseif AL_hasflag(a:flags, 'curline')
    let retval = s:FormatThreadInfo(line('.'), line('.'), 'numcheck')
  endif
  let &undolevels = save_undolevels
  " �t�H�[�}�b�g�L���b�V�����X�V
  if retval > 0
    call s:WriteFormatedCache_Subject(b:host, b:board)
  endif
endfunction

function! s:RemoveNGWords()
  " NG���[�h�̍폜
  if exists('g:chalice_ngwords') && g:chalice_ngwords.'X' !=# 'X'
    " ���[�J�����ځ[��p�u������������\�z
    let mx = '\m^\([^,]*\),\([^,]*\),\([^,]*\)$'
    let label = substitute(g:chalice_localabone, '[<>]', '', 'g')
    if label !~# mx
      let label = s:label_localabone
    endif
    let localabone = AL_sscan(label, mx, '\1').'<>'.AL_sscan(label, mx, '\2').'<><>'.AL_sscan(label, mx, '\3').'<>'
    " �e�P��ɑ΂��ă��[�J�����ځ[��𔻒肵�Ă���
    let ngwords = g:chalice_ngwords
    while ngwords != ''
      let ngw = AL_firstline(ngwords)
      let ngwords = AL_lastlines(ngwords)
      if ngw != ''
	call AL_execute('silent! 2,$g/'.ngw."/call setline('.','".localabone."')")
      endif
    endwhile
    call AL_del_lastsearch()
  endif
endfunction

function! s:UpdateFormatCache()
  " �t�H�[�}�b�g�L���b�V���̍X�V
  if s:fcachedir_enabled && exists('b:host') && exists('b:board') && exists('b:dat')
    " DAT���`�L���b�V��(��������)
    let cacheid = s:GetPath_FormatedCache(b:host, b:board, b:dat)
    let filename = CACHEMAN_update(s:fcachedir, cacheid)
    "call AL_echokv('filename', filename)
    if filename.'X' !=# 'X'
      call AL_write(filename)
    endif
  endif
endfunction

function! s:FormatThreadWhole(local, enc)
  " �o�b�t�@�N���A�ƃX��dat�̓ǂݍ���
  call AL_buffer_clear()
  if a:enc.'X' !=# 'X'
    call AL_execute('read ++enc='.a:enc.' '.a:local)
  else
    call AL_execute('read '.a:local)
  endif
  normal! gg"_dd
  " �ŏI�L���ԍ����擾
  let b:chalice_lastnum = line('$')
  " NG���[�h
  call s:RemoveNGWords()
  " Do the ���`
  call s:EchoH('WarningMsg', s:msg_wait_threadformat)
  let retval = Dat2Text(g:chalice_verbose > 0 ? 'verbose' : '')
  " Board�\���ǉ�
  if exists('b:host') && exists('b:board') && exists('b:dat')
    call append(2, 'Board: '.s:GenerateBoardURL(b:host, b:board))
    call append(3, 'URL: '.s:GenerateThreadURL(b:host, b:board, b:dat, 'raw'))
    " �t�H�[�}�b�g�L���b�V���̍X�V
    call s:UpdateFormatCache()
  endif
  return retval
endfunction

function! s:FormatThread(local, ...)
  let flags = a:0 > 0 ? a:1 : ''
  let fcachedfile = ''
  " �L���b�V���ς݃t�@�C���̌���
  if s:fcachedir_enabled && exists('b:host') && exists('b:board') && exists('b:dat')
    let cacheid = s:GetPath_FormatedCache(b:host, b:board, b:dat)
    if AL_hasflag(flags, 'ignorecache')
      call CACHEMAN_clear(s:fcachedir, cacheid)
    else
      let fcachedfile = CACHEMAN_getpath(s:fcachedir, cacheid)
    endif
  endif

  " �X�����`���
  let retval = 0
  let save_undolevels = &undolevels
  set undolevels=-1
  if fcachedfile.'X' !=# 'X' && filereadable(fcachedfile)
    " ���݂���΃t�H�[�}�b�g�L���b�V����ǂݍ��݁A�����𐮌`����B
    call AL_buffer_clear()
    call AL_execute("read ++enc= " . fcachedfile)
    normal! gg"_dd
    call s:FormatThreadDiff(a:local, s:GetArticleNum('$') + 1, s:GetHostEncoding(b:host))
    let retval = s:formatthreadpartion_title
  else
    if exists('b:host')
      let retval = s:FormatThreadWhole(a:local, s:GetHostEncoding(b:host))
    else
      let retval = s:FormatThreadWhole(a:local, '')
    endif
  endif
  let &undolevels = save_undolevels
  return retval
endfunction

function! s:FormatThreadDiff(local, newarticle, enc)
  let contents = s:FormatThreadPartial(a:local, a:newarticle, -1, a:enc)
  " �X���o�b�t�@�֑}��
  if AL_countlines(contents) > 0
    call s:GoBuf_Thread()
    normal! G$
    call AL_append_multilines(contents)
  else
    call s:GoBuf_Thread()
    normal! G0
  endif
  " �ŏI�L���ԍ���ۑ�
  let b:chalice_lastnum = s:GetArticleNum('$')
  " DAT�T�C�Y���X�V
  let b:datutil_datsize = getfsize(a:local)
  call setline(2, 'Size: '.(b:datutil_datsize / 1024).'KB')
  " �t�H�[�}�b�g�L���b�V���̍X�V
  call s:UpdateFormatCache()
endfunction

function! s:FormatThreadPartial(local, n_start, n_end, enc)
  if a:enc.'X' !=# 'X'
    call AL_execute('vertical 1sview ++enc='.a:enc.' '.a:local)
  else
    call AL_execute('vertical 1sview '.a:local)
  endif
  call s:RemoveNGWords()
  let s:formatthreadpartion_title = DatGetTitle()
  " ���`���
  let contents = ''
  let i = a:n_start
  let n_end = a:n_end < 0 || a:n_end > line('$') ? line('$') : a:n_end
  let on_verbose = 0
  if n_end - a:n_start > 50
    call AL_echo(s:msg_wait_threadformat, 'WarningMsg')
    if g:chalice_verbose > 0
      let on_verbose = 1
    endif
  endif
  while i <= n_end
    if on_verbose  && i % 100 == 0
      call AL_echo(i.'/'.n_end, 'WarningMsg')
    endif
    let contents =  contents ."\r". DatLine2Text(i, getline(i))
    let i = i + 1
  endwhile
  silent! bwipeout!
  return substitute(contents, "\r", "\<NL>", 'g')
endfunction

function! s:FormatThreadInfoWithoutUndo(startline, endline, ...)
  let save_undolevels = &undolevels
  set undolevels=-1
  let flags = a:0 > 0 ? a:1 : ''
  call s:FormatThreadInfo(a:startline, a:endline, flags)
  let &undolevels = save_undolevels
endfunction

"
" endline��0���w�肷��ƃo�b�t�@�̍Ō�B
"
function! s:FormatThreadInfo(startline, endline, ...)
  call s:GoBuf_ThreadList()
  " �o�b�t�@���X���ꗗ�ł͂Ȃ������ꍇ�A���I��
  if s:opened_bookmark || b:host == '' || b:board == ''
    return 0
  endif
  let flags = a:0 > 0 ? a:1 : ''

  let modified = 0
  let i = a:startline
  let lastline = a:endline ? a:endline : line('$')
  let threshold_time = localtime() - g:chalice_threadinfo_expire

  " �e�X����dat�t�@�C�������݂��邩�`�F�b�N���A���݂���ꍇ�ɂ͍ŏI�擾����
  " ���`�F�b�N���A����ɂ���ċ����̎d����ς���B
  " 1. dat�����݂��ߋ�chalice_threadinfo_expire���ɍX�V ��!���s����
  " 2. dat�����݂��ߋ�chalice_threadinfo_expire�O�ɍX�V ��+���s����
  while i <= lastline
    let curline = getline(i)
    if curline =~ s:mx_thread_dat
      " �^�C�g���A�������ݐ��Adat�����擾
      let title = AL_sscan(curline, s:mx_thread_dat, '\1')
      let point = AL_sscan(curline, s:mx_thread_dat, '\2') + 0
      let dat	= AL_sscan(curline, s:mx_thread_dat, '\3')
      " ���[�J��DAT�AAbone�t���O�t�@�C�����擾
      let local = s:GenerateLocalDat(b:host, b:board, dat)
      let abone = s:GenerateAboneFile(b:host, b:board, dat)
      " �t�@�C�������݂���Ȃ�΃t�@�C�������擾
      let indicator = ' '
      let time = ''
      let artnum = 0
      if filereadable(abone)
	let indicator = 'x'
      elseif filereadable(local)
	let lasttime = getftime(local)
	let indicator = threshold_time > lasttime ? '+' : '*'
	let time = strftime("%Y/%m/%d %H:%M:%S", lasttime)
	" �����̏����ݐ����`�F�b�N
	if AL_hasflag(flags, 'numcheck')
	  let artnum = s:CountLines(local)
	  if artnum > 0
	    if point > artnum
	      let indicator = '!'
	    else
	      let point = artnum
	    endif
	  endif
	else
	  let artnum = -1
	endif
      endif
      " ���C���̓��e���ω����Ă�����ݒ�
      let newline = indicator.' '.title.' ('.(artnum >= 0 ? artnum : '???').'/'. point.') '.time."\t\t\t\t".dat
      if curline !=# newline
	call setline(i, newline)
	let modified = modified + 1
      endif
    endif
    let i = i + 1
  endwhile

  normal! 0
  return modified
endfunction

function! s:FormatBoard()
  " subject.txt�̐��`�B�e�^�C�v���̒u���p�^�[����p��
  " ������ƖƉu�A���S���Y���I(��)
  let mx_shitaraba  = '^\(\d\+_\d\+\)<>\(.\{-\}\)<>\(\d\+\)<><>NULL<>$'
  let mx_mikage	    = '^\(\d\+\.\%(dat\|cgi\)\),\(.*\)(\(\d\+\))$'
  let mx_2ch	    = '^\(\d\+\.dat\)<>\(.*\) (\(\d\+\))$'
  let out_pattern   = '  \2 (\3)\t\t\t\t\1'

  " �ǂ̃^�C�v���𔻒�B�f�t�H���g��2ch�`��
  let firstline = getline(1)
  let mx = mx_2ch
  let b:format = '2ch'
  if firstline =~ mx_shitaraba
    " ������΂̏ꍇ
    let mx = mx_shitaraba
    let out_pattern = out_pattern . '.dat'
    let b:format = 'shitaraba'
  elseif firstline =~ mx_mikage
    " mikage�̏ꍇ
    let mx = mx_mikage
    let b:format = 'mikage'
  endif

  " ���`�����s
  call AL_execute('%s/' .mx. '/' .out_pattern)
  " ���ꕶ���ׂ�
  call AL_decode_entityreference_with_range('%')
  call AL_del_lastsearch()

  if g:chalice_threadinfo
    call s:FormatThreadInfo(1, 0, g:chalice_autonumcheck != 0 ? 'numcheck' : '')
  endif
endfunction

"}}}

"------------------------------------------------------------------------------
" BBS WRAPPER {{{
" BBS�̎�ʂ��B�����邽�߂̃��b�p�[
"

function! s:DatCatchup(host, board, dat, flags)
  if a:host =~ s:mx_servers_jbbstype
    let dat = substitute(a:dat, '\.dat$', '.cgi', '')
    let retval = s:DatCatchup_JBBS(a:host, a:board, dat, a:flags)
  else
    let retval = s:DatCatchup_2ch(a:host, a:board, a:dat, a:flags)
  endif
  return retval
endfunction

function! s:GenerateWriteURL(host, board, key, ...)
  " host, board, key, flag���炫���ݗpURL�𐶐�����
  let flags = a:0 > 0 ? a:1 : ''
  if a:host =~ s:mx_servers_jbbstype
    let url = ' http://' . a:host . '/bbs/write.cgi'
  elseif a:host =~ s:mx_servers_shitaraba
    let url = ' http://' . a:host . '/cgi-bin/bbs.cgi'
  else
    let url = ' http://' . a:host . '/test/bbs.cgi'
  endif
  return url
endfunction

function! s:GenerateRemoteSubject(host, board, ...)
  let flags = a:0 > 0 ? a:1 : ''
  if a:host =~ s:mx_servers_shitaraba
    let url = '/bbs'.b:board.'/subject.txt'
  else
    let url = b:board.'/subject.txt'
  endif
  return url
endfunction

function! s:GenerateBoardURL(host, board, ...)
  if a:host =~ s:mx_servers_shitaraba
    return 'http://'.b:host.'/bbs'.b:board.'/'
  else
    return 'http://'.b:host.b:board.'/'
  endif
endfunction

" Flags:
"   NONE	�ŐV50��URL
"   raw		�X���b�h�S�̂�URL
"   internal	�X���b�h�S�̂�URL
"   onlyone	1�݂̂�URL
function! s:GenerateThreadURL(host, board, key, ...)
  " host, board, key, flag����J���ׂ�URL�𐶐�����
  let flags = a:0 > 0 ? a:1 : ''
  let board = substitute(a:board, '^/', '', '')
  let key = substitute(a:key, '\.\(dat\|cgi\)$', '', '')
  if a:host =~ s:mx_servers_jbbstype
    if a:host =~ s:mx_servers_machibbs
      let url = 'http://'.a:host.'/bbs/read.pl?BBS='.board.'&KEY='.key
    else
      let url = 'http://'.a:host.'/bbs/read.cgi?BBS='.board.'&KEY='.key
    endif
    if AL_hasflag(flags, 'onlyone')
      let url = url . '&START=1&END=1'
    elseif !AL_hasflag(flags, 'internal') && !AL_hasflag(flags, 'raw')
      let url = url . '&LAST=50'
    endif
  elseif a:host =~ s:mx_servers_shitaraba
    let url = 'http://'.a:host.'/cgi-bin/read.cgi?key='.key.'&bbs='.board
    if AL_hasflag(flags, 'onlyone')
      let url = url . '&START=1&END=1'
    elseif !AL_hasflag(flags, 'internal') && !AL_hasflag(flags, 'raw')
      let url = url . '&ls=50'
    endif
  else
    let url = 'http://'.a:host.'/test/read.cgi/'.board.'/'.key.'/'
    if AL_hasflag(flags, 'onlyone')
      let url = url . '1n'
    elseif !AL_hasflag(flags, 'internal') && !AL_hasflag(flags, 'raw')
      let url = url . 'l50'
    endif
  endif
  return url
endfunction

" OUT:
"   s:parseurl_host
"   s:parseurl_board
"   s:parseurl_dat
"   s:parseurl_range_start
"   s:parseurl_range_end
"   s:parseurl_range_mode
function! s:ParseURL(url)
  let retval = 0
  if s:ParseURL_is2ch(a:url)
    let retval = 1
  elseif s:ParseURL_isJBBS(a:url)
    let retval = 1
  elseif s:ParseURL_isShitaraba(a:url)
    let retval = 1
  endif
  "echo 'host='.s:parseurl_host.' board='.s:parseurl_board.' dat='.s:parseurl_dat
  "echo 'start='.s:parseurl_range_start.' end='.s:parseurl_range_end.' mode='.s:parseurl_range_mode
  return retval
endfunction

"}}}

"------------------------------------------------------------------------------
" JBBS {{{
" JBBS/�������/�܂�BBS�Ή��p
"

function! s:ParseURL_isShitaraba(url)
  let host = AL_sscan(a:url, s:mx_url_parse, '\1')
  let path = AL_sscan(a:url, s:mx_url_parse, '\2')
  let argq = AL_sscan(a:url, s:mx_url_parse, '\3')
  let mark = AL_sscan(a:url, s:mx_url_parse, '\4')
  if host !~ s:mx_servers_shitaraba
    return 0
  endif
  if path ==# 'cgi-bin/read.cgi'
    let s:parseurl_host  = host
    let s:parseurl_board = AL_sscan(argq, 'bbs=\([^/&]\+\)', '/\1')
    let s:parseurl_dat   = AL_sscan(argq, 'key=\(\d\+_\d\+\)', '\1')
    let s:parseurl_range_mode = ''
    let s:parseurl_range_start = ''
    let s:parseurl_range_end = ''
    let mx_list = 'ls=\(\d\+\)'
    let mx_res  = 'res=\(\d\+\)'
    if argq =~ mx_list
      let s:parseurl_range_mode  = s:parseurl_range_mode . 'l'
      let s:parseurl_range_start = AL_sscan(argq, mx_list, '\1')
    elseif argq =~ mx_res
      let s:parseurl_range_start = AL_sscan(argq, mx_res, '\1')
      let s:parseurl_range_end	 = s:parseurl_range_start
    else
      " �\���͈͎w��
      let s:parseurl_range_start = AL_sscan(argq, 'st=\(\d\+\)', '\1')
      let s:parseurl_range_end   = AL_sscan(argq, 'to=\(\d\+\)', '\1')
      if s:parseurl_range_start != ''
	" �\���͈͎w��I�v�V���� (r: folding�g�p, n: 1��\��)
	let s:parseurl_range_mode  = s:parseurl_range_mode . 'r'
      endif
      if argq =~ 'nofirst=true'
	let s:parseurl_range_mode  = s:parseurl_range_mode . 'n'
      endif
    endif
    return 1
  endif
  return 0
endfunction

function! s:ParseURL_isJBBS(url)
  let mx = '^http://\(..\{-\}\)/bbs/read.\%(cgi\|pl\)?BBS=\([^/&]\+\)&KEY=\(\d\+\)\(.*\)'
  if a:url !~ mx
    return 0
  endif

  let s:parseurl_host = AL_sscan(a:url, mx, '\1')
  let s:parseurl_board = AL_sscan(a:url, mx, '/\2')
  let s:parseurl_dat = AL_sscan(a:url, mx, '\3') . '.cgi'

  let s:parseurl_range_mode = ''
  let s:parseurl_range_start = ''
  let s:parseurl_range_end = ''
  let range = AL_sscan(a:url, mx, '\4')
  if range != ''
    let mx_range_start = '&START=\(\d\+\)'
    let mx_range_end = '&END=\(\d\+\)'
    let mx_range_last = '&LAST=\(\d\+\)'
    let mx_range_nofirst = '&NOFIRST=TRUE'
    if range =~ mx_range_start
      let s:parseurl_range_start = AL_sscan(range, mx_range_start, '\1')
    endif
    if range =~ mx_range_end
      let s:parseurl_range_end = AL_sscan(range, mx_range_end, '\1')
    endif
    if s:parseurl_range_start == ''
      let s:parseurl_range_start = 1
    endif
    if s:parseurl_range_end == ''
      let s:parseurl_range_end = '$'
    endif
    let s:parseurl_range_mode = s:parseurl_range_mode . 'r'
    if range =~ mx_range_nofirst
      let s:parseurl_range_mode = s:parseurl_range_mode . 'n'
    endif
    if range =~ mx_range_last
      let s:parseurl_range_mode = s:parseurl_range_mode . 'l'
      let s:parseurl_range_start = AL_sscan(range, mx_range_last, '\1')
    endif
  endif
  return 1
endfunction

function! s:DatCatchup_JBBS(host, board, dat, flags)
  let local = s:GenerateLocalDat(a:host, a:board, a:dat)
  call AL_mkdir(AL_basepath(local))
  let prevsize = getfsize(local)
  let oldarticle = 0
  " �����擾�p�̃t���O
  let continued = 0
  if AL_hasflag(a:flags, 'continue') && filereadable(local)
    let continued = 1
    let oldarticle = s:CountLines(local)
  endif

  let newarticle = oldarticle + 1

  if !s:dont_download && !AL_hasflag(a:flags, 'noforce')
    let tmpfile = tempname()
    let bbs = substitute(a:board, '^/', '', '')
    let key = substitute(a:dat, '\.cgi$', '', '')
    " WORKAROUND: �܂�BBS�ł�read.pl���g�����ق��������B
    let cgi = a:host =~# s:mx_servers_machibbs ? 'read.pl' : 'read.cgi'
    if continued
      let remote = '/bbs/'.cgi.'?BBS='.bbs.'&KEY='.key.'&START='.newarticle.'&NOFIRST=TRUE'
    else
      let remote = '/bbs/'.cgi.'?BBS='.bbs.'&KEY='.key
    endif
    let result = s:HttpDownload(a:host, remote, tmpfile, '')
    let result = s:Convert_JBBSHTML2DAT(local, tmpfile, continued, s:GetHostEncoding(a:host))
    call delete(tmpfile)
    if !result
      " �X�������݂��Ȃ�
      call s:GoBuf_Thread()
      call AL_buffer_clear()
      call setline(1, 'Error: '.s:msg_error_nothread)
      call append('$', 'Error: '.s:msg_error_accesshere)
      call append('$', '')
      call append('$', '  '.s:GenerateThreadURL(a:host, a:board, a:dat))
      let b:host = a:host
      let b:board = a:board
      let b:dat = a:dat
      let b:title = s:prefix_thread
      let b:title_raw = ''
      return 0
    endif
  endif

  call s:GoBuf_Thread()
  let b:datutil_datsize = getfsize(local)
  if AL_hasflag(a:flags, 'ifmodified') && prevsize >= b:datutil_datsize
    return -1
  endif

  call s:UpdateThreadInfo(a:host, a:board, a:dat)
  let b:chalice_local = local
  return newarticle
endfunction

function! s:Convert_JBBSHTML2DAT(datfile, htmlfile, continued, enc)
  " jbbs.net�Ajbbs.shitaraba.com�Amachibbs.com��cgi�A�E�g�v�b�g����́B
  " 1���X��<dt>�v�f����n�܂�1�s�Ō`������Ă���A���̗l�Ȍ`���i���ʁj�F
  "
  " <dt>1 ���O�F<b>NAME</b> ���e���F 2002/05/29(��) 00:48<br><dd>�{�� <br><br>
  " ^^^^^^^^^^^^           ^^^^^^^^^                     ^^^^^^^^    ^^^^^^^^^
  "
  " ��� '^' �Ŏ������������폜�A�܂��͋�؂蕶�� '<>' �ɒu�����邱�ƂŁA2
  " ������dat�`���ɕϊ�����B

  call AL_execute('1vsplit ++enc='.a:enc.' '.a:htmlfile)
  if !a:continued
    " �S�擾�̏ꍇ�A�^�C�g����ێ����Ă���
    call search('<title>')
    let title = AL_sscan(getline('.'), '<title>\([^<]*\)</title>', '\1')
  endif
  " �����[�g�z�X�g�̃A�h���X�\���@�\������i�܂��AJBBS�̈ꕔ�j�ŁA�L������
  " �}���������s���C���B��F
  "
  " <dt>1 ���O�F<b>NAME</b> ���e���F 2002/07/12(��) 14:55 [ remote.host.ip ]<br><dd> �{�� <br><br>
  if getline(search('^<dt>') + 1) =~ '^\s*]'
    silent g/^<dt>/join
  endif
  silent v/^<dt>/delete _
  silent %s+^<dt>\d\+\s*���O�F\%(<a href="mailto:\([^"]*\)">\)\?\(.\{-\}\)\%(</a>\)\?\s*���e���F\s*\(.*\)\s*<br>\s*<dd>+\2<>\1<>\3<>+ie
  if getline(1) !~ '^$'
    if a:continued
      silent %s/\s*\(<br>\)\+$/<>/
      call AL_write(a:datfile, 1)
    else
      silent 1s/\s*\(<br>\)\+$/\='<>'.title/
      if line('$') > 1
	silent 2,$s/\s*\(<br>\)\+$/<>/
      endif
      call AL_write(a:datfile)
    endif
  endif
  silent! bwipeout!
  if !filereadable(a:datfile)
    return 0
  else
    return 1
  endif
endfunction

function! s:CreateWriteChunk_JBBS(host, board, key, title, name, mail, message, submitkey, ...)
  " jbbs.net, jbbs.shitaraba.com, machibbs.com�p�̏������݃f�[�^�`�����N�쐬
  let chunk = ''
  let chunk = chunk . 'submit=' . a:submitkey
  " BBS��KEY��b:write_params�ɂ�苟�������̂ŁA�����I�ɒǉ�����K�v�͖���
  if !b:newthread
    "let chunk = chunk . '&KEY=' . b:key
  else
    let chunk = chunk . '&SUBJECT=' . AL_urlencode(a:title)
  endif
  let chunk = chunk . '&NAME=' . AL_urlencode(a:name)
  let chunk = chunk . '&MAIL=' . AL_urlencode(a:mail)
  let chunk = chunk . '&MESSAGE=' . AL_urlencode(a:message)
  "let chunk = chunk . '&BBS=' . b:bbs
  if !b:newthread
    if exists('b:write_params')
      let chunk = chunk . b:write_params
    endif
  else
    let chunk = chunk . '&TIME=' . b:key
  endif
  return chunk
endfunction

"}}}

"------------------------------------------------------------------------------
" AUTHENTICATION FUNCTIONS {{{
" 2ch�F�؊֘A

let s:sessionid = ''
let s:last_loginid = ''
let s:last_password = ''

if s:debug
  function! ChaliceDebugLogin()
    call AL_echokv('DOLIB_get_useragent(s:sessionid)', DOLIB_get_useragent(s:sessionid))
    call AL_echokv('DOLIB_get_sessionid(s:sessionid)', DOLIB_get_sessionid(s:sessionid))
    call AL_echon(' '.strlen(DOLIB_get_sessionid(s:sessionid)), 'WarningMsg')
    call AL_echokv('DOLIB_get_logintime(s:sessionid)', DOLIB_get_logintime(s:sessionid))
    call AL_echokv('s:last_loginid', s:last_loginid)
    call AL_echokv('s:last_password', s:last_password)
    if exists('g:chalice_lastchunk')
      call AL_echokv('g:chalice_lastchunk', g:chalice_lastchunk)
    endif
    if exists('s:last_downloadcommand')
      call AL_echokv('s:last_downloadcommand', s:last_downloadcommand)
    endif
    if exists('s:getofflawdat')
      call AL_echokv('s:getofflawdat', s:getofflawdat)
    endif
  endfunction

  function! ChaliceEnsureLogin()
    call s:EnsureLogin()
  endfunction

  function! ChaliceForceLogin()
    call s:EnsureLogin('force')
  endfunction

  function! ChaliceGetOfflaw(host, board, dat)
    return s:GetOfflawDat(a:host, a:board, a:dat, 'offlaw.txt')
  endfunction
endif

function! s:GetUserAgent()
  call s:EnsureLogin()
  let useragent = DOLIB_get_useragent(s:sessionid)
  if useragent.'X' !=# 'X'
    return useragent
  else
    return 'Monazilla/1.00 (Chalice/'.s:version.')'
  endif
endfunction

function! s:AddSidToChunk(chunk)
  call s:EnsureLogin()
  let sid = DOLIB_get_sessionid(s:sessionid)
  if sid.'X' !=# 'X'
    return a:chunk . '&sid='.AL_urlencode(sid)
  else
    return a:chunk
  endif
endfunction

function! s:GenerateRemoteOfflaw(host, board, dat)
  call s:EnsureLogin()
  let sid = DOLIB_get_sessionid(s:sessionid)
  let board = substitute(a:board, '^/', '', '')
  let dat = substitute(a:dat, '.dat$', '', '')
  if sid.'X' !=# 'X'
    return '/test/offlaw.cgi/'.board.'/'.dat.'/?raw=0.0&sid='.AL_urlencode(sid)
  else
    return ''
  endif
endfunction

function! s:ResetSession()
  let s:sessionid = ''
  let s:last_loginid = ''
  let s:last_password = ''
  return 0
endfunction

function! s:EnsureLogin(...)
  let flags = a:0 > 0 ? a:1 : ''
  if !exists('g:chalice_loginid') || g:chalice_loginid.'X' ==# 'X' || !exists('g:chalice_password') || g:chalice_password.'X' ==# 'X'
    return s:ResetSession()
  endif
  " ���Ƀ��O�C���ł��Ă��邩�̃`�F�b�N
  if !AL_hasflag(flags, 'force') && !DOLIB_isexpired(s:sessionid) && s:last_loginid ==# g:chalice_loginid && s:last_password ==# g:chalice_password
    return 1
  endif
  " ���O�C�����s
  call s:Redraw('force')
  call AL_echo(s:msg_wait_login, 'WarningMsg')
  let s:sessionid = DOLIB_login(g:chalice_loginid, g:chalice_password, 'Chalice/'.s:version, 'curlpath='.s:cmd_curl)
  if s:sessionid.'X' !=# 'X'
    let s:last_loginid = g:chalice_loginid
    let s:last_password = g:chalice_password
    return 1
  else
    return 0
  endif
endfunction

function! s:GetOfflawDat(host, board, dat, local)
  if s:debug
    let s:getofflawdat = 'host='.a:host .' board='.a:board .' dat='.a:dat .' local='.a:local
  endif
  let remote = s:GenerateRemoteOfflaw(a:host, a:board, a:dat)
  if remote.'X' ==# 'X'
    " Can't login
    return 0
  endif
  " Download file
  let result = s:HttpDownload(a:host, remote, a:local, '')
  if !filereadable(a:local)
    return 0
  endif
  call AL_execute('1vsplit ++enc= ++bad=keep '.a:local)
  let result = getline(1)
  normal! gg"_dd
  call AL_write()
  silent! bwipeout!
  if result =~# '^+OK'
    return 1
  else
    call delete(a:local)
    return 0
  endif
endfunction

"}}}

"------------------------------------------------------------------------------
" COMMAND REGISTER {{{
" �R�}���h�o�^���[�`��
"   ���I�ɓo�^�\�ȃR�}���h�͓��I�ɓo�^����
"

function! s:CommandRegister()
  command! ChaliceQuit			call <SID>ChaliceClose('')
  command! ChaliceQuitAll		call <SID>ChaliceClose('all')
  command! ChaliceGoBoardList		call <SID>GoBuf_BoardList()
  command! ChaliceGoThreadList		call <SID>GoBuf_ThreadList()
  command! ChaliceGoThread		call <SID>GoBuf_Thread()
  command! -nargs=1 ChaliceGoArticle	call <SID>GoThread_Article(<q-args>)
  command! -nargs=1 Article		call <SID>GoThread_Article(<q-args>)
  command! -nargs=? ChaliceOpenBoard	call <SID>OpenBoard(<f-args>)
  command! -nargs=? ChaliceOpenThread	call <SID>OpenThread(<f-args>)
  command! ChaliceHandleJump		call <SID>HandleJump('internal')
  command! ChaliceHandleJumpExt		call <SID>HandleJump('external')
  command! ChaliceReloadBoardList	call <SID>UpdateBoardList(1)
  command! -nargs=1 ChaliceReloadThreadList	call <SID>UpdateBoard('', '', '', <q-args>)
  command! ChaliceReloadThread		call <SID>UpdateThread('', '', '', '', 'ignorecache,force')
  command! ChaliceReloadThreadInc	call <SID>UpdateThread('', '', '', '', 'continue,force')
  command! -nargs=1 ChaliceReformat	call <SID>Reformat(<q-args>)
  command! ChaliceDoWrite		call <SID>DoWriteBuffer('')
  command! -nargs=? ChaliceWrite	call <SID>OpenWriteBuffer(<f-args>)
  command! -nargs=1 ChaliceHandleURL	call <SID>HandleURL(<q-args>, 'internal')
  command! -nargs=1 ChaliceBookmarkToggle	call <SID>ToggleBookmark(<q-args>)
  command! -nargs=1 ChaliceBookmarkAdd	call <SID>Thread2Bookmark(<q-args>)
  command! ChaliceJumplist		call <SID>JumplistDump()
  command! ChaliceJumplistNext		call <SID>DoHistoryJump('next')
  command! ChaliceJumplistPrev		call <SID>DoHistoryJump('prev')
  command! ChaliceDeleteThreadDat	call <SID>DeleteThreadDat()
  command! ChaliceAboneThreadDat	call <SID>AboneThreadDat()
  command! ChaliceToggleNetlineStatus	call <SID>ToggleNetlineState()
  command! -nargs=* ChalicePreview	call <SID>OpenPreview(<q-args>)
  command! ChalicePreviewClose		call <SID>ClosePreview()
  command! ChalicePreviewToggle		call <SID>TogglePreview()
  command! -nargs=* ChaliceCruise	call <SID>Cruise(<q-args>)
  command! -nargs=* ChaliceShowNum	call <SID>ShowNumberOfArticle(<q-args>)
  command! -nargs=* ChaliceCheckThread	call <SID>CheckThreadUpdate(<q-args>)
  command! -nargs=* Chalice2HTML	call <SID>ShowWithHtml(<f-args>)
  command! ChaliceAdjWinsize		call <SID>AdjustWindowSizeDefault()
  if s:debug || !s:datdir_enabled == 0
    command! ChaliceDatdirOn		call <SID>DatdirOn()
  endif
  delcommand Chalice
endfunction

function! s:CommandUnregister()
  command! Chalice			call <SID>ChaliceOpen()
  delcommand ChaliceQuit
  delcommand ChaliceQuitAll
  delcommand ChaliceGoBoardList
  delcommand ChaliceGoThreadList
  delcommand ChaliceGoThread
  delcommand ChaliceGoArticle
  delcommand Article
  delcommand ChaliceOpenBoard
  delcommand ChaliceOpenThread
  delcommand ChaliceHandleJump
  delcommand ChaliceHandleJumpExt
  delcommand ChaliceReloadBoardList
  delcommand ChaliceReloadThreadList
  delcommand ChaliceReloadThread
  delcommand ChaliceReloadThreadInc
  delcommand ChaliceReformat
  delcommand ChaliceDoWrite
  delcommand ChaliceWrite
  delcommand ChaliceHandleURL
  delcommand ChaliceBookmarkToggle
  delcommand ChaliceBookmarkAdd
  delcommand ChaliceJumplist
  delcommand ChaliceJumplistNext
  delcommand ChaliceJumplistPrev
  delcommand ChaliceDeleteThreadDat
  delcommand ChaliceAboneThreadDat
  delcommand ChaliceToggleNetlineStatus
  delcommand ChalicePreview
  delcommand ChalicePreviewClose
  delcommand ChalicePreviewToggle
  delcommand ChaliceCruise
  delcommand ChaliceShowNum
  delcommand ChaliceCheckThread
  delcommand Chalice2HTML
  delcommand ChaliceAdjWinsize
  if exists(':ChaliceDatdirOn')
    delcommand ChaliceDatdirOn
  endif
endfunction

" �N���R�}���h�̐ݒ�
command! Chalice			call <SID>ChaliceOpen()

"}}}
