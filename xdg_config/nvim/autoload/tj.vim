""
" Helper to get autload functions easily
" Used with my `auto` snippet
function! tj#easy_autoload() abort
  if expand('%:p') =~# 'autoload'
    " Santize from windows
    let autoload_name = std#file#name(expand('%:p'))
    let autoload_name = split(autoload_name, 'autoload/')[-1]
    let autoload_name = fnamemodify(autoload_name, ':r')
    let autoload_name = substitute(autoload_name, '/', '#', 'g')
    let autoload_name = autoload_name . '#'

    return autoload_name
  endif

  return ''
endfunction

""
" List occurences
function! tj#list_occurrences(...) abort
  if a:0 > 0
    let l:search_string = a:1
  else
    let l:search_string = expand('<cword>')
  endif

  let l:objects = split(execute('g/' . l:search_string . '/p'), "\n")
  let l:loc_objects = []

  for l:obj in l:objects
    call add(l:loc_objects, {
          \ 'bufnr': bufnr('%'),
          \ 'lnum': str2nr(substitute(l:obj, '\(^\s*\d*\s\).*', '\1', '')),
          \ 'col': 1,
          \ 'text': substitute(l:obj, '^\s*\d*\s*', '', ''),
          \ })
  endfor

  call setloclist(0,
        \ l:loc_objects,
        \ )

  lwindow
  return l:loc_objects
endfunction

""
" Find project root
function! tj#find_project_root(...) abort
  let l:project_location_list = split(expand('%:p:h'), '/')

  for index in range(len(l:project_location_list))
    if isdirectory('/' . join(l:project_location_list[0:index], '/') . '/.git')
      return '/' . join(l:project_location_list[0:index], '/') . '/'
    endif
  endfor

  return expand('%:p:h')
endfunction

function! tj#dict_to_formatted_json(dict) abort
  if type(a:dict) != v:t_dict
    return
  endif

  call std#window#temp({'buftype': 'nofile', 'filetype': 'json', 'vertical': v:true})

  let l:buffer_number = nvim_buf_get_number(0)

  call nvim_buf_set_lines(l:buffer_number, 0, -1, 1, std#json#format(tj#json_encode(a:dict)))

  silent! call dictwatcherdel(a:dict, '*', 's:dict_watcher_func')

  function! s:dict_watcher_func(d, k, z) abort closure
    call nvim_buf_set_lines(l:buffer_number, 1, -1, 1, std#json#format(tj#json_encode(a:d)))
  endfunction

  call dictwatcheradd(a:dict, '*', function('s:dict_watcher_func'))
endfunction


" Times the number of times a particular command takes to execute the specified number of times (in seconds).
function! tj#profile( command, numberOfTimes )
  " We don't want to be prompted by a message if the command being tried is
  " an echo as that would slow things down while waiting for user input.
  let more = &more
  set nomore
  let startTime = localtime()
  for i in range( a:numberOfTimes )
    execute a:command
  endfor
  let result = localtime() - startTime
  let &more = more
  return result
endfunction

function! tj#code_review_yank() abort
  let file_name = expand('%')
  let line_number = line('.')
  let line_contents = getline('.')

  echo printf("[%s]\n%s: %s", file_name, line_number, line_contents)
endfunction

function! tj#visual_code_review() abort
  let [l:lnum1, l:col1] = getpos("'<")[1:2]
  let [l:lnum2, l:col2] = getpos("'>")[1:2]
  " 'selection' is a rarely-used option for overriding whether the last
  " character is included in the selection. Bizarrely, it always affects the
  " last character even when selecting from the end backwards.
  if &selection !=# 'inclusive'
    let l:col2 -= 1
  endif
  let l:lines = getline(l:lnum1, l:lnum2)
  if !empty(l:lines)
    " If there is only 1 line, the part after the selection must be removed
    " first because `col2` is relative to the start of the line.
    let l:lines[-1] = l:lines[-1][: l:col2 - 1]
    let l:lines[0] = l:lines[0][l:col1 - 1 : ]
  endif

  let final_string = ''

  let file_name = expand('%')
  let final_string .= printf("File: %s\r\n\r\n", file_name)

  let current_line = lnum1
  for line in lines
    let final_string .= printf("[%4s] > %s\r\n", current_line, line)

    let current_line += 1
  endfor

  call setreg('*', final_string)
  call setreg('+', final_string)
  let g:_visual_code_yank = final_string
endfunction

vnoremap yc <c-r>:call tj#visual_code_review()<CR>
xnoremap yc <c-r>:call tj#visual_code_review()<CR>

function! tj#save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif

  return
endfunction
