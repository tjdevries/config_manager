" Don't use this anymore, but I do want to take some ideas for this
if v:true
  finish
endif

setlocal foldmethod=marker

imap <buffer> <C-T> <Plug>VimwikiIncreaseLvlSingleItem<c-o>a
imap <buffer> <C-D> <Plug>VimwikiDecreaseLvlSingleItem<c-o>a

let g:mywiki_date_string = "%Y-%m-%d"

" ,w - wiki {{{

" l - link {{{
function! s:set_wiki_link() abort
  let modifiers = ''
  if expand('%:e') == 'wiki'
    let modifiers .= ':r'
  endif

  let file_name = tj#standard_file_name(expand('%' . modifiers))
  let wiki_path = tj#standard_file_name(g:vimwiki_path)

  let subbed_path = substitute(file_name, '^' . wiki_path, '', '')

  let link = printf('[[/%s|%s]]',
        \ file_name,
        \ expand('%:t:r')
        \ )
  echo printf('Setting register + -> %s', link)

  call setreg('+', link)
endfunction

nnoremap ,wl :call <SID>set_wiki_link()<CR>
" }}}
" p - projects  {{{
nnoremap ,wp :call execute('Denite file -path=' . g:vimwiki_path . '/projects')<CR>
" }}}
" m - meetings  {{{
nnoremap ,wm :call execute('Denite file -path=' . g:vimwiki_path . '/meetings')<CR>
" }}}

" e - edit {{{
function! s:edit_file(folder, prompt)
  let file_name = input(a:prompt)
  call execute(printf('e %s/%s/%s %s.wiki',
        \ g:vimwiki_path,
        \ a:folder,
        \ strftime(g:mywiki_date_string),
        \ file_name
        \ ))
endfunction

" p - projects {{{
nnoremap ,wep :call <SID>edit_file('projects', 'New Project: ')<CR>
" }}}
" m - meetings {{{
nnoremap ,wem :call <SID>edit_file('meetings', 'New Meeting: ')<CR>
" }}}
" }}}
" }}}
