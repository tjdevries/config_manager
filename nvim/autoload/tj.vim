
""
" Selectively highlight through several specific options
" to set the color for a specific group
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
  for filename in sort(glob(search_dir . '/' . extension, 0, 1))
    let file_tail = split(filename, '/')[-1]
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
function! tj#easy_autoload() abort
  if expand('%') =~# 'autoload'
    let autoload_name = split(expand('%'), 'autoload/')[-1]
    let autoload_name = substitute(autoload_name, '\.vim', '', 'g')
    let autoload_name = substitute(autoload_name, '/', '#', 'g')
    let autoload_name = autoload_name . '#'

    put ='function! ' . autoload_name
    norm! kJ
  endif
endfunction

""
" Determine if we're in a git repository
function! tj#is_git_file() abort
  let system_reply = system('( cd ' . shellescape(expand('%:h')) . '; git ls-files ' . shellescape(expand('%:t')) . ' --error-unmatch;)')

  " If fatal is in the name, then it's not in a git repo
  " If error is in the name, then it's not currently tracked
  if system_reply =~? 'fatal: Not a git repo' || 
        \ system_reply =~? 'error: pathspec'
    return v:false
  else
    return v:true
  endif
endfunction

""
" Simple caching for buffer variables
" TODO: Maybe make this take in a argument for the scope?
function! tj#buffer_cache(name, function) abort
  if exists('b:' . a:name)
    return b:{a:name}
  else
    let b:{a:name} = eval(a:function)
    return b:{a:name}
  endif
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
      return join(l:project_location_list[0:index], '/') . '/'
    endif
  endfor

  return expand('%:p:h')
endfunction

