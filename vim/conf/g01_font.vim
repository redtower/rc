"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  "set gfn=Terminal:h10:cSHIFTJIS
  "set gfn=Osaka－等幅:h10:cSHIFTJIS
  set gfn=M+2VM+IPAG_circle:h12:cSHIFTJIS
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  " set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
else
  set gfn=Monospace\ 11
endif
