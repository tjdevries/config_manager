""
" 
function! sql#execute_file(...) abort

  if a:0 > 0
    let db_name = a:1
  else
    let db_name = g:db_name
  endif


  let current_file = expand('%:p')
  let command = printf('r !runas /epic\tdevries sqlcmd -d %s -S square -i "%s" -y0 -s~', db_name, current_file)

  if !has_key(b:, '__sql_result')
    let b:__sql_result = std#window#temp()
  endif

  call std#window#goto(b:__sql_result)
  call execute(command)

  Tabularize/\~
  silent! %s/\~/  |  /g

  echo command
endfunction

let s:chunks = get(s:, 'chunks', [''])
function! s:handle_output(output, id, data, event)
  let clean_data = copy(a:data)

  " Clear any empty lines
  call filter(clean_data, { index, val ->val != '' })
  " Remove line-end characters
  call map(clean_data, { index, val -> substitute(val, '\(\s\|\n\|\r\)\+$', '', 'g')})

  if len(clean_data) == 0
    return
  endif

  let a:output[-1] .= clean_data[0]

  if len(clean_data) == 1
    return
  endif

  call extend(a:output, clean_data[1:])
endfunction

function! s:handle_error(id, data, event)
  let g:error_stuff = a:data
endfunction

function! sql#complete_column_name() abort
  let database_server = 'square'
  let database_name = 'HP_2018Stage1QA_Sql'
  let file_name = g:init_base . 'bin/sql/ms_get_columns.sql'

  let line = getline('.')[0:col('.')]
  let match = matchlist(line, '\(\w\+\)\.\(\w*\)\s*$')

  if len(match) < 3
    return ''
  endif

  let options = sql#request(database_server, database_name, file_name, 0, {
        \ 'TableName': match[1],
        \ 'ColumnStart': match[2],
        \ })

  " \ 'kind': 
  call map(options, { idx, val -> {
          \ 'word': val,
          \ 'menu': printf('[%s].[%s]', database_name, match[1]),
          \ 'icase': 1,
          \ }
        \ })

  call complete(col('.') - len(match[2]), options)
  return ''
endfunction

function! sql#request(database_server, database_name, file_name, async, var) abort
  let variables = []
  for [k, v] in items(a:var)
    call insert(variables, printf("%s=%s", k, v), len(variables))
  endfor

  let command = ['sqlcmd',
        \ '-S', a:database_server,
        \ '-d', a:database_name,
        \ '-i', a:file_name,
        \ '-W',
        \ '-h', '-1',
        \ '-v',
        \ ]

  let g:__sql_cmd = command
  call extend(command, variables)

  let results = ['']
  let job_id = jobstart(command, {
          \ 'on_stdout': function('s:handle_output', [results]),
          \ 'on_stderr': function('s:handle_error'),
          \ })

  if !a:async
    call jobwait([job_id])
  endif

  return results
endfunction

function! sql#format_clipboard() abort
  normal! gg"_dG
  normal! p
  write
  let lines = systemlist(['C:\Users\tdevries\AppData\Local\Programs\Python\Python36-32\Scripts\sqlformat.exe', expand('%:p'), '-r', '-a'])

  call nvim_buf_set_lines(0, 0, -1, v:false, lines)

  silent %s///g
endfunction

function! sql#find_bad_variables() abort
  let lines = nvim_buf_get_lines(0, 0, -1, v:false)
  let qf_list = []

  let variable_starting_string = '@[^iosb]'

  for index in range(len(lines))
    let value = lines[index]
    let text = value

    let bad_var_column = match(value, variable_starting_string)
    if bad_var_column < 0
      continue
    else
      let text = matchstr(value, variable_starting_string . '\w*')
    endif

    call add(qf_list, {
          \ 'bufnr': bufnr(0),
          \ 'lnum': index + 1,
          \ 'type': 'W',
          \ 'text': text,
          \ 'col': bad_var_column,
          \ })
  endfor

  call setloclist(0, qf_list)

  if len(qf_list) > 0
    lopen
  else
    lclose
  endif

  return qf_list
endfunction


" inoremap <c-tab> <C-R>=sql#complete_column_name()<CR>
