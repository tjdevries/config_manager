function! notes#code_block() abort
  return "```vim\<CR>\<CR>```\<up>"
endfunction


" inoremap <expr> ``` notes#code_block()


let s:bullet_options = [ '-', '\.', '\~' ]

function! s:check_pattern(expr, pre_pattern, options, post_pattern)
  for option in a:options
    if matchstr(a:expr, a:pre_pattern . option . a:post_pattern) !=? ''
      return v:true
    endif
  endfor

  return v:false
endfunction


function! s:is_bullet_point(line) abort
  return s:check_pattern(a:line, '^\s*', s:bullet_options, '')
endfunction

function! s:is_only_bullet_point(line) abort
  return s:check_pattern(a:line, '^\s*', s:bullet_options, '\s*$')
endfunction

""
" Return the number of spaces / tabs preceding the bullet point
function! s:bullet_point_level(line) abort

endfunction

" I kind of want this to work like onenote does with enter
" I'm not really sure if it's efficient, but I like pressing enter
" and just do the thing I want.
function! notes#smart_list() abort
  " Check if line is equal to whitespace + -/./~/ etc.
  echo s:is_bullet_point(getline('.'))
  echo s:is_only_bullet_point(getline('.'))
endfunction


function! notes#cd_move_further() abort
  cd ..
endfunction

function! notes#cd_move_closer() abort

endfunction
