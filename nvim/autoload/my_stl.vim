scriptencoding 'utf-8'

let s:current_mode_color = ''
let s:left_sep = '\ \ '

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

    return '[' . l:mode . ']'
endfunction

function! my_stl#add_left_separator() abort
  execute('set statusline+=' . s:left_sep)
endfunction
