finish

let g:langserver_executables = {
      \ 'go': {
            \ 'name': 'sourcegraph/langserver-go',
            \ 'cmd': ['langserver-go', '-trace', '-logfile', expand('~/Desktop/langserver-go.log')],
            \ },
      \ 'python': {
            \ 'name': 'sourcegraph/python-langserver',
            \ 'cmd': ['pyls']
            \ },
      \ 'javascript,typescript,jsx,tsx': {
            \ 'name': 'javascript-typescript',
            \ 'cmd': [],
            \ },
      \ 'ocaml': {
            \ 'name': 'freebroccolo/ocaml-language-server',
            \ 'cmd': ['ocaml-language-server', '--stdio'],
            \ },
      \ }

" Old python command
" \ 'cmd': [expand('~/bin/python-langserver/python-langserver.py')],
