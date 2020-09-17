if exists("g:started_by_firenvim")
  setlocal laststatus=0
  setlocal nonumber
  setlocal norelativenumber
  setlocal noruler
  setlocal noshowcmd

  set rtp+=~/git/vai.vim/
  set completefunc=vai#completefunc

  inoremap <tab> <c-n>
  inoremap <s-tab> <c-p>
endif
