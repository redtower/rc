
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
    au! BufNewFile,BufRead  .vimperatorrc setfiletype vimperator
    au! BufNewFile,BufRead  vimperatorrc  setfiletype vimperator
    au! BufNewFile,BufRead *.tt           setfiletype html
augroup END
