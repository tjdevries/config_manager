" Tiki.vim
" My own wiki (TJ + wiki = tiki)
" Should be based on markdown, so you can print it out, or do other things
" like that with it.


let s:wiki_home = expand('~/tiki/')

function! s:prepare_env()
  " Move to wiki home
  execute 'cd ' . s:wiki_home

  " Set WIKI_HOME
  if has('win32')
    execute '!set WIKI_HOME=' . s:wiki_home
  else
    " TODO: Linux
  endif
endfunction

function! s:open_wiki()
  call s:prepare_env()
  execute 'edit ' . s:wiki_home
endfunction



" {{{ Mappings
nnoremap <leader>te :call <SID>open_wiki()<CR>

" {{{ Insert Mode helpers
inoremap <S-tab> <c-d>
" }}}
" }}}
