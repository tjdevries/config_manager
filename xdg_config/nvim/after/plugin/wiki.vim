if v:true
  finish
end

function! s:FindMap() abort
  let keymap = nvim_get_keymap('n')

  for mapping in keymap
    if stridx(mapping.rhs, 'wiki') > -1
      echo mapping.rhs
    endif
  endfor
endfunction

" echo string(filter(keymap, { k, v -> stridx(v.rhs, '<plug>(wiki') > -1 }))
let g:mkdp_command_for_global = 1

" Set my normal wiki to a dropbox location
let nested_syntaxes = {
            \ 'python': 'python',
            \ 'c': 'c',
            \ 'mumps': 'mumps',
            \ }

let g:vimwiki_path = expand('~/Dropbox/wiki/')
" let g:wiki_root = g:vimwiki_path

let g:export_path = expand('~/Dropbox/export/')

" New wiki
let g:wiki_journal = {
      \ 'name': 'journal',
      \ 'frequency': 'weekly',
      \ 'date_format': {
        \ 'weekly': '%Y_w%V'
        \ },
      \ }

let g:wiki_mappings_use_defaults = 1
let g:wiki_mappings_global = {
      \ '<plug>(wiki-index)': '<leader>ww',
      \ '<plug>(wiki-journal-index)': '<leader>wj',
      \ }

let g:wiki_mappings_local = {
      \ '<plug>(wiki-journal-prev)': '<c-Down>',
      \ '<plug>(wiki-journal-next)': '<c-Up>',
      \ '<plug>(wiki-link-next)' : '<leader><tab>',
      \ '<plug>(wiki-link-return)' : '<leader><bs>',
      \ }

" \ '<plug>(wiki-link-open-split)' : '<c-w><cr>',



" Old wiki
let g:vimwiki_folding = ''
let g:vimwiki_list = [
            \ {
                \ 'path': vimwiki_path,
                \ 'path_html': export_path . 'html/',
                \ 'template_path': export_path . 'html/vimwiki-theme/templates/',
                \ 'template_default': 'default',
                \ 'template_ext': '.html',
                \ 'auto_export': 0,
                \ 'nested_syntaxes': nested_syntaxes,
            \ },
            \ ]


" Complete paths with vimwiki
function! CompleteVimwikiPath(word) abort
  if maktaba#string#StartsWith(a:word, '[[/')
    let globbed = map(
          \ split(glob(g:vimwiki_path . a:word[3:] . '*'), "\n"),
          \ {key, value -> substitute(value, '\\', '/', 'g')}
          \ )
    let choices = filter(map(
            \ globbed,
            \ {key, value -> value[len(g:vimwiki_path):]}),
          \ 'v:val =~ "' . a:word[3:] . '"')
    call complete(col('.') - len(a:word) + 3, choices)
  endif

  return ''
endfunction

inoremap <c-x><c-w> <C-O>h<C-O>:let g:my_complete_path = '<c-r><c-a>'<cr><esc>Ea<C-R>=CompleteVimwikiPath(g:my_complete_path)<CR>

" Get the current folder of a vimwiki page
function! GetVimwikiFolder() abort
  let file_name = input('New file: ')
  let current_file = substitute(expand('%:p:h'), '\\', '/', 'g')
  let wiki_path = substitute(g:vimwiki_path, '\\', '/', 'g')

  return '[[/' . substitute(current_file, wiki_path, '', 'g') . '/' . file_name . '|' . file_name . ']]'
endfunction

inoremap <leader>wf <C-O>:call nvim_input(GetVimwikiFolder())<CR>
nnoremap <leader>wf :call nvim_input(GetVimwikiFolder())<CR>

" turn this_tag -> [:this_tag:]
inoremap wtag <C-O>b[:<C-O>e<right>:]

function! s:map_enter() abort
  if v:hlsearch
    return execute(":nohl\<CR>")
  endif

  if getline('.') =~ '\s*- \[ \]'
    return setline(line('.'), substitute(getline('.'), '^\(\s*- \)\[ \]', '\1[x]', ''))
  endif

  if getline('.') =~ '\s*- \[x\]'
    return setline(line('.'), substitute(getline('.'), '^\(\s*- \)\[x\]', '\1[ ]', ''))
  endif

  " TODO: Should I cache this?
  let keymap = nvim_get_keymap('n')
  if has_key(keymap, '<Plug>(wiki-link-open)')
    return execute("normal <Plug>(wiki-link-open)")
  else
    return execute("normal <Plug>VimwikiFollowLink<CR>")
  endif
endfunction

augroup tjVimWiki
  au!
  au BufNewFile,BufRead,BufEnter *.wiki set foldmethod=marker
  " au BufWritePost *.wiki VimwikiRebuildTags

  " This is probably too often... but oh well
  " Could perhaps even do it in a filetype
  au BufNewfile,BufRead,BufEnter *.wiki nnoremap <buffer> <CR> :call <SID>map_enter()<CR>
augroup END

" let g:wiki_home = $HOME .. '/.local/wiki/'
