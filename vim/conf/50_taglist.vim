" taglist - http://www.vim.org/scripts/script.php?script_id=273
if has('win32')
  let Tlist_Ctags_Cmd="ctags.exe"
else
  let Tlist_Ctags_Cmd="ctags"
endif
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
map <silent> <leader>tl :TlistToggle<CR>

let NERDSpaceDelims = 1
let NERDShutUp = 1
