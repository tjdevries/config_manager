try
  " Add some servers
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

  call lsp#server#add('rust', {
        \ 'name': 'rust/rls',
        \ 'command': 'rustup',
        \ 'arguments': ['run', 'nightly', 'rls'],
        \ })

  call lsp#server#add('lua', {
        \ 'name': 'Alloyed/lua-lsp',
        \ 'command': 'lua-lsp',
        \ 'arguments': [],
        \ })

  " \ 'command': 'typescript-language-server',
  " \ 'arguments': ['--stdio'],
  call lsp#server#add('typescript', {
        \ 'name': 'typescript-language-server',
        \ 'command': 'node',
        \ 'arguments': [expand('~/git/javascript-typescript-langserver/lib/language-server-stdio')],
        \
        \ 'callbacks': {
          \ 'root_uri': { server -> lsp#util#find_root_uri('tsconfig.json')},
          \ },
        \ })

  augroup LSP/me
    au!

    for ft in ['python', 'go', 'rust', 'lua', 'typescript']
      call execute(
        \ printf('autocmd FileType %s setlocal omnifunc=lsp#completion#omni',
          \ ft))

      call execute(
        \ printf(
          \ 'autocmd FileType %s inoremap <buffer> <c-n> '
          \ . '<c-r>=lsp#completion#complete()<CR>',
          \ ft))

      call execute(
        \ printf('autocmd FileType %s setlocal completeopt+=preview', ft))
    endfor
  augroup END

  " call lsp#configure('textDocument/didChange', ['InsertLeave', 'TextChanged'])
  " call lsp#conigure#option('request.timeout', 5)
catch

endtry
