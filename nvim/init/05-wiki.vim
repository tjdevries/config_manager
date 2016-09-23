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

