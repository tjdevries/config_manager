let g:stdout_powershell_result = []

let g:powershell_temp_file = expand('~/.powershell_temp_file')
let g:powershell_job_id = jobstart('powershell.exe',
      \ {
        \ 'on_stdout': {id, data, event -> nvim_set_var('_powershell_command_complete', data)},
        \ 'on_stderr': {id, data, event -> nvim_set_var('_powershell_command_complete', v:true)},
        \ 'on_exit': {-> nvim_set_var('powershell_exit', localtime())},
      \ })

function! powershell#command(string) abort
  return system('powershell.exe ' . a:string)
endfunction

function! powershell#job(string) abort
  let g:_powershell_command_complete = []
  let g:_powershell_last_command = a:string . ' | Set-Content "' . g:powershell_temp_file . '"'
  call jobsend(g:powershell_job_id, g:_powershell_last_command)
  call jobsend(g:powershell_job_id, 'Write-Host "Complete"')

  while len(g:_powershell_command_complete) == 0
    sleep 10m
  endwhile

  return readfile(g:powershell_temp_file)
endfunction

function! powershell#get_file(name) abort
  return printf('Get-Item -Path %s', expand(a:name))
endfunction

function! powershell#get_property(name, property) abort
  return system()
endfunction


