
" Semshi configuration
let g:semshi#error_sign = v:false

let s:job_options = {}

let s:job_options.stdout_buffered = v:true
function! s:job_options.on_stdout(id, data, event) dict abort
  let g:result = a:data
endfunction

function! s:job_options.on_stderr(id, data, event) dict abort
  let g:result = a:data
endfunction


function! s:check_types() abort
  " TODO: Add optional filename / pattern

  if expand('%:e') != 'py'
    let g:result = 'bad'
    return
  endif

  let g:result = 'pending'

  let $MYPYPATH='mypydir/mypy-django:mypydir/sourceress'
  let $PYTHONPATH='core:web:deploy'

  return jobstart([
        \ 'mypy', 
        \ '--config-file', expand('~/sourceress/mypy.ini'),
        \ '--ignore-missing-imports', 'web/',
        \ expand('%:p:h')], s:job_options)
endfunction

function! CheckTypes() abort
  return s:check_types()
endfunction

augroup SourceressAuto
  au!
  autocmd BufWritePost *.py :Semshi highlight

  " TODO: Get this to work correctly
  " autocmd BufWritePost *.py :call <SID>check_types()
augroup END
