" This will just do some basic pulling of repos that already exist in the
" g:plug_home using powershell.

function! s:win_update_plugins() abort
  call execute('vnew')

  let g:win_update_id = jobstart(
        \ [
          \'powershell.exe',
          \ '-Command', 
          \ '& { cd ' . expand(g:plug_home) . '; Get-ChildItem -Directory | ForEach-Object { cd C:\Users\tdevries\nvim_plug\$_; echo "Updating " $_.FullName "..."; cd $_.FullName; git pull }; echo "DONE" }'
          \ ],
        \ {
          \ 'on_stdout': {job, data, event ->
            \ execute('call append(line("$"),' . string(data) . ')')
            \ },
          \ 'on_stderr': {job, data, event ->
            \ execute('call append(line("$"), ["err" ] + ' . string(data) . ')')
            \ },
          \ }
        \ )
endfunction

command! PlugUpdateWin call <sid>win_update_plugins()
