""
" 
function! sql#execute_file() abort
  let current_file = expand('%:p')
  new
  call execute(printf('r !sqlcmd -d HP_2018Stage1QA_Sql -S square -i "%s" -y0 -s~', current_file))
  Tabularize/\~
  silent! %s/\~/  |  /g
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

inoremap <c-tab> <C-R>=sql#complete_column_name()<CR>
