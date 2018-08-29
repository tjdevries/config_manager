
if !isdirectory($VIMRUNTIME . '/lua/lsp/')
  finish
end

" Add some servers
call lsp#server#add('python', 'pyls', {'name': 'palantir/python-language-server'})
call lsp#server#add('lua', 'lua-lsp')

lua require('lsp.api').config.log.set_file_level('debug')
lua require('lsp.api').config.log.set_outfile('~/debug_file.txt')

" autocmd User LSP/textDocument/references/post echom { -> &filetype == 'qf' ? execute('wincmd p') . 'EXECUTED' : '' }()

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

function! s:handle_publish_diagnostics() abort
  let loc_list = getloclist(0)

  if loc_list == []
    lclose
    return
  endif

  lopen
  wincmd p
endfunction

augroup LSP/test
  au!

  autocmd User LSP/textDocument/publishDiagnostics/notification call s:handle_publish_diagnostics()

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
