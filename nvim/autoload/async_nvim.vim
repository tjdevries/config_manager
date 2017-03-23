
if has('win32')
  let s:nvim_bin = expand('~/Downloads/Neovim/Neovim/bin/nvim.exe')
else
  let s:nvim_bin = 'nvim'
end

function! async_nvim#get_nvim() abort
  let g:_my_async = jobstart([s:nvim_bin, ' --embed'],
      \ {
        \ 'rpc': v:true,
      \ }
    \ )

        " \ 'on_stdout': { id, data, event ->
        "   \ execute('call append(line("$"), ' . string(a:data))
        "   \ },

  return g:_my_async
endfunction


