
if has('win32')
  let s:os_sep = '\\'
else
  let s:os_sep = '/'
endif


""
" Selectively highlight through several specific options
" to set the color for a specific group
" Has pretty much been replaced by the cooler colorpal
"
" @arg style: A string naming the highlight style
" @arg list_of_groups: A list of strings, naming the group to apply
function! tj#my_highlighter(style, list_of_groups) abort
  for group in a:list_of_groups
    if hlexists(group)
      call execute('hi! link ' . a:style . ' ' . group)
      break
    endif
  endfor
endfunction

""
" A dictionary containing key: value pairs to run through my_highlighter
" Has pretty much been replaced by the cooler colorpal
function! tj#highlight_customize(color_dict) abort
  for my_color in keys(a:color_dict)
    call tj#my_highlighter(my_color, a:color_dict[my_color])
  endfor
endfunction

""
" Helper function to list all the current files, with a nice name prefix
"
" @arg directory: The directory to search in
" @arg prefix: The prefix to place before the result in the final unite list
" @arg extension (optional): The extension pattern that you want to use to
"   find the correct files
function! tj#unite_file_lister(directory, prefix, ...) abort
  if len(a:000) == 0
    let extension = '*.vim'
  else
    let extension = a:1
  endif

  let search_dir = expand(a:directory)

  let unite_list = []
  for filename in sort(glob(search_dir . s:os_sep . extension, 0, 1))
    let file_tail = split(filename, s:os_sep)[-1]
    call add(unite_list, [a:prefix . file_tail, filename])
  endfor

  return unite_list
endfunction

""
" Helper function to do nice stuff with tags
function! tj#tag_mover(direction) abort
  execute(':t' . a:direction)
endfunction

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
" Determine if we're in a git repository
function! tj#is_git_file() abort
  let file_location = expand('%:p:h')
  let file_name = expand('%:t')

  return tj#is_git_file_wrapper(file_location, file_name)
endfunction

function! tj#is_git_file_wrapper(location, name)
  let file_location = a:location
  let file_name = a:name

  let system_command = ''
  if has('win32')
    let system_command .= 'powershell.exe -Command '
  else
    let system_command .= '( '
  endif

  let system_command .= 'cd '
        \ . file_location
        \ . '; git ls-files '
        \ . file_name
        \ . ' --error-unmatch;'

  if has('win32')
  else
    let system_command .= ' )'
  endif

  let system_reply = system(system_command)

  " Debug reply
  " return [file_location, file_name, system_command, system_reply, v:shell_error]

  if v:shell_error
    return v:false
  else
    return v:true
  endif
endfunction

""
" Simple caching for buffer variables
" Can take a timeout, to update casually
" TODO: Maybe make this take in a argument for the scope?
function! tj#buffer_cache(name, function, ...) abort
  " Set the timeout
  if a:0 > 0
    let timeout = a:1
  else
    let timeout = -1
  endif

  return std#cache#get(b:, a:name, a:function, timeout)
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

function! tj#vimgrep_from_root(...) abort
  " call execute(':vimgrep /' . expand('<cword>') . '/gj * ' . tj#find_project_root() . '**')
  " call execute(':GrepperAg ' . expand('<cword>') . ' ' . tj#find_project_root() . '**')
  " call execute(':GrepperAg ' . expand('<cword>') . ' ' . tj#find_project_root() . '**')
endfunction

function! tj#join_lines() abort
  if &filetype == 'vim'
    if getline(line('.') + 1) =~ '^\s*\\'
      let old_reg = getreg('/')
      normal! J
      set lazyredraw
      call nvim_input('v/\s<CR>"_d')
      call timer_start(100, {timer-> execute("call setreg('/', '" . old_reg . "')")})
      set nolazyredraw
      nohl
      return
    endif
  endif

  normal! J
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

" TODO: Replace several of the paths with simple `json_encode` functionality.
" Probably would be faster?
function! tj#json_encode(val) abort
  if type(a:val) == v:t_number
    return a:val
  elseif type(a:val) == v:t_string
    let json = '"' . escape(a:val, '\"') . '"'
    let json = substitute(json, "\r", '\\r', 'g')
    let json = substitute(json, "\n", '\\n', 'g')
    let json = substitute(json, "\t", '\\t', 'g')
    let json = substitute(json, '\([[:cntrl:]]\)', '\=printf("\x%02d", char2nr(submatch(1)))', 'g')
    return iconv(json, &encoding, "utf-8")
  elseif type(a:val) == v:t_func
    let s = substitute(string(a:val), 'function(', '', '')[:-2]

    let args_split = split(s, ', ')

    if len(args_split) <= 1
      return tj#json_encode(substitute(args_split[0], "'", '', 'g'))
    endif

    let func_name = tj#json_encode(substitute(args_split[0], "'", '', 'g'))

    let json = '['
    let json .= func_name . ','

    " TODO: Show context here for dict_functions
    " execute 'let g:temp_dict = ' . join(args_split[1:], ', ')
    " let args_split = [
    "       \ g:temp_dict
    "       \ ]
    " let json .= tj#json_encode(g:temp_dict)

    " In the meantime, just say "self"
    let json .= '"self"'
    let json .= ']'

    return json
  elseif type(a:val) == 3
    return '[' . join(map(copy(a:val), 'tj#json_encode(v:val)'), ',') . ']'
  elseif type(a:val) == v:t_dict
    return '{' . join(map(
          \ keys(a:val),
          \ 'tj#json_encode(v:val).":".tj#json_encode(a:val[v:val])'), ',')
        \ . '}'
  elseif type(a:val) == v:t_bool
    if a:val
      return 'true'
    else
      return 'false'
    endif
  endif
endfunction

function! tj#opt(option, val, to_execute) abort
  call execute('let g:_ = &' . a:option)
  call execute('let &' . a:option . ' = ' . a:val)
  call execute('normal! ' . a:to_execute)
  call execute('let &' . a:option . ' = g:_')
endfunction

function! tj#find_func(func_name) abort
  " Only required if you don't want to save before going to function
  set hidden

  let result = split(execute('verbose function ' . a:func_name), "\n")
  let file_name = substitute(result[1], '\s*Last set from ', '', '')
  call execute(':e ' . file_name)
  call search('function\%[!] ' . a:func_name)
endfunction

" my_stl#add_left_separator('asdf')

nnoremap ,gf :call tj#find_func(expand('<cword>'))<CR>

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

function! tj#standard_file_name(file_name) abort
  return std#file#name(a:file_name)
endfunction
