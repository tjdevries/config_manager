
let s:last_response = {}

function! s:set_response(id, data, event) abort
  let s:last_response[a:event] = a:data
endfunction

function! term_test#open()
  let s:original_window = nvim_buf_get_number(0)
  let s:job_id = jobstart([&shell], {
        \ 'on_stdout': funcref('s:set_response'),
        \ 'on_stderr': funcref('s:set_response'),
        \ })
endfunction


function! term_test#send(text)
  echo jobsend(s:job_id, a:text . "\n")
endfunction

function! term_test#response()
  return s:last_response
endfunction

function! term_test#json()
  call tj#dict_to_formatted_json(s:last_response)
endfunction


function! term_test#pstree() abort
  if nvim_buf_get_option(0, 'filetype') != 'term'
    return
  endif

  let result = systemlist(['pstree', nvim_buf_get_var(0, 'terminal_job_pid'), '-A', '-T', '-u', '-g', '-a'])

  let recent = result[-1]
  let recent = trim(recent)
  let recent = substitute(recent, '^`-', '', '')

  let name = split(recent, ',')[0]
  let args = get(split(recent, ' '), 1, ' ')

  " echo name
  " echo args

  return name . ' ' . args
endfunction

