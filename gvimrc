" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
:let filelist = glob("~/$VIMFILE_DIR/conf/g[0-9]*")
:let splitted = split(filelist, "\n")
:for file in splitted
    :let $fconf = file
    source $fconf
:endfor

