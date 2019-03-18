
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
