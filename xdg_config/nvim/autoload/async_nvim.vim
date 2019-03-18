
if has('win32')
  let s:nvim_bin = expand('~/Downloads/Neovim/Neovim/bin/nvim.exe')
else
  let s:nvim_bin = 'nvim'
end

function! async_nvim#get_nvim() abort
  let g:_my_async = jobstart([s:nvim_bin, '--embed'],
      \ {
        \ 'rpc': v:true,
      \ }
    \ )

        " \ { 'rpc': v:true, }

  return g:_my_async
endfunction

function! async_nvim#eval_func(func, params) abort
  let jobid = get(g:, '_my_async', v:false)

  if !jobid
    let jobid = async_nvim#get_nvim()
  endif

  return jobid
endfunction

""
" Async version of if we're in a git file or not
function! async_nvim#is_git_file() abort
  let file_location = expand('%:p:h')
  let file_name = expand('%:t')

  let func_name = 'tj#is_git_file_wrapper'
  let func_args = [file_location, file_name]

  return async_nvim#eval_func(func_name, func_args)
endfunction

" echo rpcrequest(g:_my_async, 'nvim_eval', '"Hello " . "world!"')
" echo rpcnotify(g:_my_async, 'nvim_eval', '"Hello " . "world!"')

" echo jobsend(g:_my_async, msgpackdump(['nvim_eval', '"Hello " . "world!"']))
