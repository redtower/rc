" vim:set ts=8 sts=2 sw=2 tw=0:
"
" datutil.vim
"
" Written By:  MURAOKA Taro <koron@tka.att.ne.jp>

scriptencoding cp932

let s:version_serial = 2
let s:name = 'datutil'
if exists('g:plugin_'.s:name.'_disable') || (exists('g:version_'.s:name) && g:version_{s:name} > s:version_serial)
  finish
endif
let g:version_{s:name} = s:version_serial

let s:debug = 0

"------------------------------------------------------------------------------
" INTERFACES:
"   :call Dat2Text()

"------------------------------------------------------------------------------
" IMPEMENTATION POINT:

function! s:GetMx(linestr, ...)
  let flags = a:0 > 0 ? a:1 : ''
  if AL_hasflag(flags, '2ch') || a:linestr =~ s:GetMx_bbs2ch()
    let s:mx_article = s:GetMx_bbs2ch()
    return '2ch'
  elseif AL_hasflag(flags, 'modoki') || a:linestr =~ s:GetMx_bbsmodoki()
    let s:mx_article = s:GetMx_bbsmodoki()
    return 'modoki'
  else
    let s:mx_article = s:GetMx_bbs2ch()
    return '2ch'
  endif
endfunction

function! s:GetMx_bbs2ch()
  " 2ch�X���b�h�A�t�H�[�}�b�g�p�^�[��

  " �������ݎ����̐؂蕪��
  "   �X����dat�̃t�H�[�}�b�g�́A���O�ɍs���ɍs(�L��)�ԍ���t���Ă���̂�:
  "	�ԍ�<>���O<>���[��<>����<>�{��<>�X����
  "   �ƂȂ�B�X�����͐擪�̂�
  let m1 = '\(.\{-}\)<>' " \{-}�͍ŒZ�}�b�`
  let mx = '^\(\d\+\)<>'.m1.m1.m1.'\s*\(.\{-\}\)\s*<>\s*\(.*\)$'
  return mx
endfunction

function! s:GetMx_bbsmodoki()
  let m1 = '\([^,]*\),'
  let mx = '^\(\d\+\)<>' . m1.m1.m1.m1 . '\s*\(.*\)$'
  return mx
endfunction

function! s:FormatArticle(linestr, ...)
  let flags = a:0 > 0 ? a:1 : ''
  if a:linestr =~ s:mx_article
    let retval = substitute(a:linestr, s:mx_article, '\r--------\r\1  From:\2  Date:\4  Mail:\3\r  \5', '')
  else
    let retval = substitute(a:linestr, '\(\d\+\)<>\(.*\)', '\r--------\r\1  !!BROKEN!!\r  \2', '')
  endif
  let retval = substitute(retval, ' \?<br> \?', '\r  ', 'g')
  let retval = substitute(retval, '<\/\?a[^>]*>', '', 'g')
  let retval = substitute(retval, '\s*<\/\?b>', '', 'g')
  let retval = substitute(retval, '\c<\/\?font[^>]*>', '', 'g')
  if AL_hasflag(flags, 'modoki')
    let retval = substitute(retval, '���M', ',', 'g')
  endif
  return retval
endfunction

function! s:Dat2Text_loop(linestr)
  if s:dat2text_verbose && s:dat2text_count % 100 == 0
    call AL_echo(s:dat2text_count.'/'.b:datutil_last_article_num, 'WarningMsg')
  endif
  let retval = s:FormatArticle(a:linestr, exists('b:datutil_format') ? b:datutil_format : '')
  let s:dat2text_count = s:dat2text_count + 1
  return escape(retval, '\\')
endfunction

function! DatLine2Text(artnum, datline, ...)
  let inval = a:artnum.'<>'.a:datline
  let flags = a:0 > 0 ? a:1 : ''
  let format = s:GetMx(inval, flags)
  let retval = s:FormatArticle(inval, format)
  return AL_decode_entityreference(retval)
endfunction

function! DatGetTitle()
  let firstline = '0<>' . getline(1)
  let b:datutil_format = s:GetMx(firstline)
  let b:datutil_title = AL_decode_entityreference(substitute(firstline, s:mx_article, '\6', ''))
  return b:datutil_title
endfunction

function! Dat2Text(...)
  let flags = a:0 > 0 ? a:1 : ''
  let s:dat2text_count = 1
  let s:dat2text_verbose = AL_hasflag(flags, 'verbose') ? 1 : 0
  " �X���b�h�t�H�[�}�b�g�p�^�[��������
  call DatGetTitle()

  " ��ŕ\���ʒu�𒲐����邽��
  let curline = line('.')
  " �K�v�Ȃ�΃o�b�t�@�T�C�Y���擾����
  let not_filesize = 0
  if !exists('b:datutil_datsize')
    let not_filesize = 1
    let b:datutil_datsize = line2byte(line('$') + 1)
  endif
  " ������datutil���ŏ�ɐݒ肷��
  let b:datutil_last_article_num = line('$')

  " ���`�Ǝ��̎Q�Ƃ̉���
  %s/^.*$/\=s:Dat2Text_loop(s:dat2text_count."<>".submatch(0))/
  call AL_decode_entityreference_with_range('%')
  call AL_del_lastsearch()
  unlet s:dat2text_count
  unlet s:dat2text_verbose

  " �w�b�_�[���쐬
  call setline(1, 'Title: '. b:datutil_title)
  let size_kb = (b:datutil_datsize / 1024) . 'KB'
  let line = 1
  call append(line, 'Size: ' . size_kb . (not_filesize ? ' (NOT FILESIZE)' : ''))
  let line = line + 1
  call append(line, '') " HTML��MAIL�w�b�_�[���ɂ��Ă���
  let line = line + 1

  " �K�v�Ȃ�΃J�[�\���ʒu�𐮌`�O�ɂ������L���ֈړ�
  if AL_hasflag(flags, 'keepline')
    call search('^'.curline.' ', 'w')
  endif
  redraw!

  return b:datutil_title
endfunction

function! DatLine2HTML(artnum, datline)
  let inval = a:artnum.'<>'.a:datline
  let format = s:GetMx(inval)

  " HTML���ɕK�v�ȏ��v�f�����o��
  let numb = substitute(inval, s:mx_article, '\1', '')
  let name = substitute(inval, s:mx_article, '\2', '')
  let mail = substitute(inval, s:mx_article, '\3', '')
  let date = substitute(inval, s:mx_article, '\4', '')
  let cont = substitute(inval, s:mx_article, '\5', '')
  let retval = ''

  " �e�v�f�̐��`
  let name = '<b>'.name.'</b>'
  let cont = substitute(cont, '\(\%(https\?\|ftp\)://'.g:AL_pattern_class_url.'\+\)', '<a href="\1">\1</a>', 'g')

  " HTML�Ƃ��Đ��`
  let retval = retval.'<dt>'.numb.' �F'
  if mail != ''
    let retval = retval.'<a href="mailto:'.mail.'">'.name.'</a>'
  else
    let retval = retval.'<font color="green">'.name.'</font>'
  endif
  let retval = retval.' �F'.date
  let retval = retval.'</dt>'
  let retval = retval.'<dd>'.cont.'</dd>'
  let retval = retval.'<br /><br />'

  if format ==# 'modoki'
    let retval = substitute(retval, '���M', ',', 'g')
  endif
  return retval
endfunction

function! Dat2HTML(dat, startnum, endnum, url_base, url_board)
  " dat����e�L����HTML�𐶐�
  if !filereadable(a:dat)
    return ''
  endif
  let startnum = a:startnum
  let endnum = a:endnum

  call AL_execute('vertical 1sview '.a:dat)
  " �^�C�g���̎擾
  let title = DatGetTitle()
  " �\���͈͎w��̌���
  let artnum = line('$')
  if startnum < 1
    let startnum = 1
  elseif startnum > artnum
    let startnum = artnum
  endif
  if endnum < startnum
    let endnum = startnum
  elseif endnum > artnum
    let endnum = artnum
  endif

  " �X���R���e���c������HTML���쐬
  let contents = ''
  let i = startnum
  while i <= endnum
    let contents = contents.DatLine2HTML(i, getline(i))."\n"
    let i = i + 1
  endwhile
  silent! bwipeout!

  " HTML�쐬
  let retval = ''
  " HTML�w�b�_
  let retval = retval.'<html>'."\n"
  let retval = retval.'<head>'."\n"
  if a:url_base != ''
    let retval = retval.'<base href="'.a:url_base.'">'."\n"
  endif
  let retval = retval.'<title>'.title.'</title>'."\n"
  " �X�^�C���V�[�g�o��
  if 1
    let retval = retval."<style type=\"text/css\">\n"
    " AA�p�t�H���g�ݒ�
    if has('win32')
      let retval = retval."body { font-size:12pt; font-family:\"�l�r �o�S�V�b�N\"; }\n"
    endif
    let retval = retval."</style>\n"
  endif
  let retval = retval.'</head>'."\n"
  let retval = retval.'<body bgcolor="#efefef" text="black" link="blue" alink="red" vlink="#660099">'."\n"
  " �����N(��Έʒu�w��)
  if a:url_board != ''
    let retval = retval.'<a href="'.a:url_board.'">���f���ɖ߂遡</a>'."\n"
  endif
  let retval = retval.'<a href="./">�S��</a>'."\n"
  let i = 1
  while i < artnum
    let url_num = (i != 1 ? i : '').'-'.(i + 99)
    let retval = retval.'<a href="'.url_num.'">'.i.'-</a>'."\n"
    let i = i + 100
  endwhile
  let retval = retval.'<a href="l50">�ŐV50</a>'."\n"
  " �X���^�C
  let retval = retval.'<p><font size="+1" color="red">'.title.'</font></p>'."\n"
  " �X�����e
  let retval = retval.'<dl>'."\n"
  let contents = substitute(contents, '<a[^>]\{-\}>\(&gt;&gt;\(\d\+\%(-\d\+\)\?\)\)</a>', '<a href="\2n" target="_blank">\1</a>', 'g')
  let retval = retval.contents
  let retval = retval.'</dl>'."\n"
  " dat���\��
  let retval = retval.'<font color="red" face="Arial"><b>'.(getfsize(a:dat)/1024).'&nbsp;KB&nbsp;(#'.artnum.')</b></font>'."\n"
  " �L��
  let retval = retval.'<font size="2"><b>&nbsp;[&nbsp;Chalice�y��Vim�ɂ��Ă̏���&nbsp;<a href="http://www.kaoriya.net/" target="_blank">KaoriYa.net</a>&nbsp;]</b></font>'."\n"
  " �����N(�_���ʒu�w��)
  let retval = retval.'<hr /><center>'."\n"
  let range = startnum . ((endnum - startnum) > 0 ? '-'.endnum : '')
  let retval = retval.'<a href="'.range.'n">�R�s�y�pURL</a>'."\n"
  let retval = retval.'<a href="'.(endnum+1).'-">����������</a>'."\n"
  let retval = retval.'<a href="'.artnum.'-">�V�����X�̕\��</a>'."\n"
  let retval = retval.'</center>'."\n"
  " �����N(���Έʒu�w��)
  let retval = retval.'<hr />'."\n"
  if startnum > 1
    let url_num = (endnum > 100 ? endnum - 100 : 1).'-'.(endnum - 1)
    let retval = retval.'<a href="'.url_num.'">�O100</a>'."\n"
  endif
  if endnum < artnum
    let url_num = (endnum + 1).'-'.(endnum < (artnum - 100) ? endnum + 100 : artnum)
    let retval = retval.'<a href="'.url_num.'">��100</a>'."\n"
  endif
  let retval = retval.'<a href="l50">�ŐV50</a>'."\n"
  " HTML�t�b�^
  let retval = retval.'</body>'."\n"
  let retval = retval.'</html>'."\n"

  return retval
endfunction

if s:debug
  function! Test_Dat2Text(...)
    let flags = a:0 > 0 ? a:1 : ''
    setlocal buftype=nofile nowrap
    call Dat2Text(flags)
  endfunction
endif
