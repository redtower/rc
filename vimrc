" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)

if has('win32') || has('win64')
  " Windowsの場合の処理
  :let $VIMFILE_DIR = 'vimfiles'
else
  " Windows以外の場合の処理
  :let $VIMFILE_DIR = '.vim'
endif

:let $LOCALVIM = '~/$VIMFILE_DIR/local/'

:let filelist = glob("~/$VIMFILE_DIR/conf/[0-9]*")
:let splitted = split(filelist, "\n")
:for file in splitted
    :let $fconf = file
    source $fconf
:endfor

"---------------------------------------------------------------------------
" ChangeLog関連の設定ファイル
if filereadable($HOME . '/rc/private/changelog.vim')
  source ~/rc/private/changelog.vim
endif
