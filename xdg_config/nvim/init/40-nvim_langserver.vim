

if !g:builtin_lsp
  " TODO: Could probably add a bunch of these for typecript + react.
  "     Not sure exactly how I got those to work last time.

  let g:coc_global_extensions = [
        \ 'coc-python',
        \ 'coc-json',
        \ 'coc-tag',
        \ 'coc-emoji',
        \ 'coc-syntax',
        \ 'coc-vimlsp',
        \ ]

  nmap gd <Plug>(coc-definition)

  inoremap <silent><expr> <c-space> coc#refresh()

  finish
endif

if !g:builtin_lsp
  let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls'],
        \ 'lua': ['lua-lsp'],
        \ }

  let g:LanguageClient_selectionUI_autoOpen = 0
  let g:LanguageClient_diagnosticsSignsMax = 0

  nnoremap <F5> :call LanguageClient_contextMenu()<CR>

  nnoremap <leader>rr :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>wr :call LanguageClient#workspace_symbol()<CR>

  " Or map each action separately
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

  " Add some stuff for custom root dirs
  let g:LanguageClient_rootMarkers = {
        \ 'python': ['__init__.py'],
        \ }

  finish
end

if !isdirectory($VIMRUNTIME . '/lua/lsp/')
  finish
end

" Add some servers
call lsp#server#add('python',
      \ ['pyls', '-v', '-v', '--log-file', '/home/tjdevries/test/python_ls_log.txt'],
      \ {'name': 'palantir/python-language-server'}
      \ )
call lsp#server#add('lua', 'lua-lsp')

lua require('lsp.api').config.callbacks.set_option('textDocument/publishDiagnostics', 'auto_list', true)
lua require('lsp.api').config.callbacks.set_option('textDocument/publishDiagnostics', 'use_quickfix', true)

lua require('lsp.api')
lua vim.lsp.config.log.set_outfile('~/test/logfile_lsp.txt')
lua vim.lsp.config.log.set_file_level('trace')
lua vim.lsp.config.log.set_console_level('info')

" call lsp#server#add('go',
"       \ ['go-langserver', '-trace', '-logfile', expand('~/lsp-go.txt')],
"       \ {'name': 'sourcegraph/go-langserver'}
"       \ )

" call lsp#server#add('rust', {
"       \ 'name': 'rust/rls',
"       \ 'command': 'rustup',
"       \ 'arguments': ['run', 'nightly', 'rls'],
"       \ })

" call lsp#server#add('lua', {
"       \ 'name': 'Alloyed/lua-lsp',
"       \ 'command': 'lua-lsp',
"       \ 'arguments': [],
"       \ })

augroup LSP/test
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
