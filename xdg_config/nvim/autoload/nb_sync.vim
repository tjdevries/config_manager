function! nb_sync#sync() abort
  let file_name = expand("%:p")

  if match(file_name, ".synced.py") < 0
    return
  endif

  let g:last_nb_sync_val = system("python -m jupyter_ascending.requests.sync --filename '" . expand("%:p") . "'")
endfunction

function! nb_sync#execute() abort
  let g:last_nb_exec_val = system("python -m jupyter_ascending.requests.execute --filename '" . expand("%:p") . "' --linenumber " . line('.'))
endfunction
