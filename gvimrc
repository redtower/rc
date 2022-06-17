" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"

if has('nvim')
  " Neovim
  :let filelist = glob("$XDG_CONFIG_HOME/nvim/config/g[0-9]*")
else
  " Vim
  :let filelist = glob("$HOME/$VIMFILE_DIR/conf/g[0-9]*")
endif

:let splitted = split(filelist, "\n")
:for file in splitted
    :let $fconf = file
    source $fconf
:endfor

