" Set my normal wiki to a dropbox location
let nested_syntaxes = {
            \ 'python': 'python',
            \ 'c': 'c',
            \ }

let vimwiki_path = expand('~/Dropbox/wiki/')
let export_path = expand('~/Dropbox/export/')


let g:vimwiki_folding=''
let g:vimwiki_list = [
            \ {
                \ 'path': vimwiki_path,
                \ 'path_html': export_path . 'html/',
                \ 'template_path': export_path . 'html/vimwiki-theme/templates/',
                \ 'template_default': 'default',
                \ 'template_ext': '.html',
                \ 'auto_export': 1,
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
