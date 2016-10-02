
""
" Selectively highlight through several specific options
" to set the color for a specific group
"
" @arg style: A string naming the highlight style
" @arg list_of_groups: A list of strings, naming the group to apply
function! tj#my_highlighter(style, list_of_groups)
  for group in a:list_of_groups
    if hlexists(group)
      call execute('hi! link ' . a:style . ' ' . group)
      break
    endif
  endfor
endfunction

""
" A dictionary containing key: value pairs to run through my_highlighter
function! tj#highlight_customize(color_dict)
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
