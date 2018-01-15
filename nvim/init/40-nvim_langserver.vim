try
  " Add some clients
  call lsp#server#add('python', {
        \ 'name': 'palantir/python-language-server',
        \ 'command': 'pyls',
        \ 'arguments': [],
        \ })
  call lsp#server#add('go', {
        \ 'name': 'sourcegraph/go-langserver',
        \ 'command': 'go-langserver',
        \ 'arguments': ['-trace', '-logfile', expand('~/lsp-go.txt')],
        \ })

  " call lsp#
catch

endtry
