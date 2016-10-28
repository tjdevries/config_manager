scriptencoding 'utf-8'

let g:currentmode = {
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

let s:current_mode_color = ''
let s:left_sep = ' >> '

function! my_stl#get_mode_highlight() abort

endfunction

function! my_stl#get_mode() abort
    let l:m = mode()
    if l:m ==# 'i'
      let l:mode = 'I'
    elseif l:m ==# 'R'
      let l:mode = 'R'
    elseif l:m =~# '\v(v|V||s|S|)'
      let l:mode = 'V'
    elseif l:m ==# 't'
      let l:mode = 'T'
    else
      let l:mode = 'N'
    endif

    return ''
          \ . my_stl#get_user_color(l:mode)
          \ . '[' 
          \ . l:mode 
          \ . ']'
          \ . '%*'
endfunction

function! my_stl#add_left_separator() abort
  return s:left_sep
endfunction

function! my_stl#set_up_colors() abort
  " exe 'CPHL User' . string(a:num) . ' ' . l:colors[a:num - 1][0] . ' ' . l:colors[a:num - 1][1]
endfunction

function! my_stl#get_user_color(mode) abort
  if a:mode ==# 'I'
    return '%1*'
  else
    return '%2*'
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

function! my_stl#get_file_name() abort
  return '%f'
endfunction
