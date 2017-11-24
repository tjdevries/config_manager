let s:styles = [
      \ 'bold',
      \ 'underline',
      \ 'undercurl',
      \ 'reverse',
      \ 'inverse',
      \ 'italic',
      \ 'standout',
      \ ]

let s:highlight_names = map(split(execute('highlight'), "\n"), {index, value -> split(value, " ")[0]})

let s:color_names = {
      \ 'aliceblue': 'f0f8ff',
      \ }

function! s:command_filter(options, lead) abort
  return filter(copy(a:options), {index, value -> matchstr(value, '^' . a:lead) != ''})
endfunction

function! CPHLComplete(arglead, cmdline, cursorpos) abort
  let line_split = split(a:cmdline, ' ')
  let arg_number = len(line_split)

  " TODO: Make sure we're in the right location...
  if arg_number == 5
      return s:command_filter(s:styles, a:arglead)
  elseif arg_number == 4 || arg_number == 3 || (arg_number == 3 && a:arglead == '') || (arg_number == 2 && a:arglead == '')
    if stridx(a:arglead, ',') > 0
      return []
    else
      return s:command_filter(keys(g:colorpal_palette) + keys(s:color_names), a:arglead)
    endif
  elseif arg_number == 2
    return s:command_filter(s:highlight_names, a:arglead)
  elseif arg_number == 1 && a:arglead == ''
    return s:highlight_names
  endif


  return [a:arglead, a:cmdline, a:cursorpos]
endfunction

command! -nargs=+ -complete=customlist,CPHLComplete CPHLTest :echo('<args>')
