"---------------------------------------------------------------------------
" �����̋����Ɋւ���ݒ�:
"
" �������ɑ啶���������𖳎� (noignorecase:�������Ȃ�)
set ignorecase
" �啶���������̗������܂܂�Ă���ꍇ�͑啶�������������
set smartcase
" �I�����������������
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" �I�������������u��
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"�������ɍŌ�܂ōs������ŏ��ɖ߂�
set wrapscan
"������������͎��ɏ����Ώە�����Ƀq�b�g�����Ȃ�
set noincsearch
" �^�O�t�@�C�����w�肷��
set tags=./tags,tags,~/.tags

