
function! repl#send_all(term_id) abort
  call chansend(a:term_id, "%cpaste\n")
  sleep 200m
  call chansend(a:term_id, nvim_buf_get_lines(0, 0, -1, v:false))
  sleep 200m
  call chansend(a:term_id, "\n--\n")
endfunction

function! repl#send_line(term_id) abort
  call chansend(a:term_id, getline('.'). "\n")
endfunction

function! repl#_find_repl() abort
  let windows = nvim_tabpage_list_wins(0)

  for vis_win in windows
    let buf_num = nvim_win_get_buf(vis_win)

    if nvim_buf_get_option(buf_num, 'filetype') == 'term'
      return nvim_buf_get_var(buf_num, 'terminal_job_id')
    endif
  endfor

  return -1
endfunction

function! repl#_django_get_model() abort
  let raw_line = getline('.')
  let line = trim(raw_line)
  let model = split(line, '(')[0]
  let model_id = split(split(line, '(')[1], ')')[0]

  call chansend(b:terminal_job_id, printf("obj_id = '%s'; obj = %s.objects.get(id=obj_id); obj\n", model_id, model))

  normal! G
endfunction

function! repl#_django_obj_json(...) abort
  let object_name = len(a:000) > 0 ? a:1 : 'obj'

  call chansend(b:terminal_job_id, printf("%s.to_json()\n", object_name))
endfunction

