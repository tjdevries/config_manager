try
  " Add some clients
  call lsp#server#add('python', {
        \ 'name': 'palantir/python-language-server',
        \ 'command': 'pyls',
        \ 'arguments': [],
        \ })
  augroup LSP/me
    au!
    autocmd Filetype python setlocal omnifunc=lsp#completion#omni
    autocmd Filetype python inoremap <buffer> <c-n> <c-r>=lsp#completion#complete()<CR>
  augroup END

  call lsp#server#add('go', {
        \ 'name': 'sourcegraph/go-langserver',
        \ 'command': 'go-langserver',
        \ 'arguments': ['-trace', '-logfile', expand('~/lsp-go.txt')],
        \ })

  call lsp#server#add('rust', {
        \ 'name': 'rust/rls',
        \ 'command': 'rustup',
        \ 'arguments': ['run', 'nightly', 'rls'],
        \ })

catch

endtry
