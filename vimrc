" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)

if has('nvim')
  " Neovim
  :let filelist = glob("$XDG_CONFIG_HOME/nvim/config/[0-9]*")

else
  " Vim
  "
  if has('win32') || has('win64')
    " Windowsの場合の処理
    :let $VIMFILE_DIR = '.vim'
  else
    " Windows以外の場合の処理
    :let $VIMFILE_DIR = '.vim'
  endif
  :let $LOCALVIM = '$HOME/$VIMFILE_DIR/local/'
  :let filelist = glob("$HOME/$VIMFILE_DIR/conf/[0-9]*")

endif


:let splitted = split(filelist, "\n")
:for file in splitted
    :let $fconf = file
    source $fconf
:endfor

"---------------------------------------------------------------------------
" ChangeLog関連の設定ファイル
source $HOME/rc/private/changelog.vim
