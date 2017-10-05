if exists('*lsp#client#add')
  " Add some clients
  call lsp#client#add('python', {
        \ 'name': 'palantir/python-language-server',
        \ 'command': 'pyls',
        \ 'arguments': [],
        \ })
  call lsp#client#add('go', {
        \ 'name': 'sourcegraph/go-langserver',
        \ 'command': 'langserver-go',
        \ 'arguments': ['-logfile', 'lsp-go.txt'],
        \ })
end
