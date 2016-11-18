
let g:langserver_executables = {
      \ 'go': {
            \ 'name': 'sourcegraph/langserver-go',
            \ 'cmd': ['langserver-go', '-trace', '-logfile', expand('~/Desktop/langserver-go.log')],
            \ },
      \ 'python': {
            \ 'name': 'sourcegraph/python-langserver',
            \ 'cmd': [expand('~/bin/python-langserver/python-langserver.py')],
            \ },
      \ }
