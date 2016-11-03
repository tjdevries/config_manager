scriptencoding 'utf-8'

" Dictionary of type:
" mode_result: ['long_string', 'short_string', 'highlight type']
let g:currentmode = {
    \ 'n'  : ['Normal', 'N', 'NormalMode'],
    \ 'no' : ['N·OpPd', '' ],
    \ 'v'  : ['Visual', 'V' ],
    \ 'V'  : ['V·Line', 'Vl' ],
    \ '^V' : ['V·Blck', 'Vb' ],
    \ 's'  : ['Select', 'S' ],
    \ 'S'  : ['S·Line', 'Sl' ],
    \ '^S' : ['S·Block', 'Sb' ],
    \ 'i'  : ['Insert', 'I', 'InsertMode'],
    \ 'R'  : ['Rplace', 'R', 'ReplaceMode'],
    \ 'Rv' : ['VRplce', 'Rv' ],
    \ 'c'  : ['Cmmand', 'C' ],
    \ 'cv' : ['Vim Ex', 'E' ],
    \ 'ce' : ['Ex (r)', 'E' ],
    \ 'r'  : ['Prompt', 'P' ],
    \ 'rm' : ['More  ', 'M' ],
    \ 'r?' : ['Cnfirm', 'Cn'],
    \ '!'  : ['Shell ', 'S'],
    \ 't'  : ['Term  ', 'T', 'TerminalMode'],
    \ }

let s:current_mode_color = ''
let s:left_sep = ' >> '

function! my_stl#get_mode_highlight() abort

endfunction

function! my_stl#get_mode() abort
    let l:m = mode()
    let l:mode = g:currentmode[l:m][1]

    if len(l:mode) > 1
      let l:leading_space = ''
    else
      let l:leading_space = ' '
    endif

    return ''
          \ . my_stl#get_user_color(l:m)
          \ . ' ['
          \ . l:mode
          \ . ']'
          \ . l:leading_space
          \ . '%*'
endfunction

function! my_stl#add_left_separator() abort
  return s:left_sep
endfunction

function! my_stl#set_up_colors() abort
  " exe 'CPHL User' . string(a:num) . ' ' . l:colors[a:num - 1][0] . ' ' . l:colors[a:num - 1][1]
endfunction

function! my_stl#get_user_color(mode) abort
  if len(g:currentmode[a:mode]) > 2
    let l:color_code = g:currentmode[a:mode][2]

    if type(l:color_code) == type(1)
      return '%' . l:color_code . '*'
    else
      return '%#' . l:color_code . '#'
    endif
  else
    let l:color_code = 9
    return '%' . l:color_code . '*'
  endif

endfunction

function! my_stl#change_user_color(num) abort
  if (mode() =~# '\v(n|no)')
    " exe 'hi StatusLine ctermfg=008'
    " exe 'highlight User' . string(a:num) . ' guibg=blue'
    let l:colors = g:colorpal_airline['normal']
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    " exe 'hi! StatusLine ctermfg=005'
  elseif (mode() ==# 'i')
    " exe 'hi! StatusLine ctermfg=004'
    " exe 'highlight User' . string(a:num) . ' guibg=red'
    " exe 'CPHL User' . string(a:num) . ' MyInsert MyInsert MyInsert'
    let l:colors = g:colorpal_airline['insert']
  else
    " exe 'hi! StatusLine ctermfg=006'
  endif


  " return ''
  return '%' . string(a:num) . '*'
endfunction

" echo my_stl#get_file_name(2, 2)

function! my_stl#get_file_name(name_length, relative_depth) abort
  " Quit for terminals
  if exists('b:term_title')
    return expand('%')
  endif

  " Handle empty buffers
  if expand('%') ==? '[No Name]'
        \ || expand('%') ==? ''
    return '[No Name]'
  endif

  let file_name = split(expand('%'), '/')
  let my_pwd = split(substitute(getcwd(winnr(), tabpagenr()), "\n", '', 'g'), '/')
  let result_name = ''

  let index = 0
  for index in range(len(file_name))
    if index >= len(my_pwd)
      break
    endif

    if file_name[index] !=# my_pwd[index]
      break
    endif
  endfor


  if len(my_pwd) - index < a:relative_depth
    for common_index in range(len(my_pwd) - index)
      let result_name .= '../'
    endfor

    " TODO: Try and prepend a './' when we don't have relative paths downard
    " if len(my_pwd) - index == 1
    "   let result_name .= './'
    " endif

    while index < len(file_name)
      let result_name .= file_name[index] . '/'
      let index += 1
    endwhile

    let result_name =  result_name[:-2]
  else
    let result_name = expand('%')
  endif


  " a:name_length letters, then any word chacters followed by a slash
  " Replace the first string with that string and "/"
  " Do it for all of them
  return substitute(result_name, '\(' . repeat('[^/]', a:name_length) . '\)[^/]*/', '\1/', 'g')
        " \ . ' ' .
        " \ winnr() . ' ' .
        " \ tabpagenr() . ' ' .
        " \ getcwd(winnr(), tabpagenr())
  " return '%f'
endfunction

function! my_stl#get_git() abort
  let stl = ''

  " Check for git information
  if exists('*fugitive#head') && (
              \ exists('b:git_dir')
              \ || len(fugitive#head(8)) > 0
              \ )
      let stl .= "\ue0a0 "
      let stl .= fugitive#head(8)

      if exists('*GitGutterGetHunkSummary')
          let results = GitGutterGetHunkSummary()

          if results != [0, 0, 0]
            let diff_symbols = ['+', '~', '-']

            let diff_line = ''
            for i in range(3)
                if results[i] > 0
                    let diff_line .= l:diff_symbols[i] . string(results[i]) . ', '
                endif
            endfor

            let stl .= ' [' . diff_line[:-3] . ']'
          endif
      endif

      let stl .= my_stl#add_left_separator()
  endif

  return stl
endfunction
