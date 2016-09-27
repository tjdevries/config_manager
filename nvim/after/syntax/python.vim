let s:my_colors = {
      \ 'pythonSelf':  ['GruvboxPurpleItalic', 'Constant'],
      \ 'pythonSelfArg': ['GruvboxGrayItalic', 'Comment'],
      \ 'pythonImportedObject':  ['GruvboxBlueSign', 'PreProc'],
      \ 'pythonBuiltin': ['GruvboxOrange', 'Keyword'],
      \ 'pythonBuiltinObj':  ['GruvboxOrange', ],
      \ 'pythonBuiltinFunc': ['GruvboxOrange', 'Function'],
      \ 'pythonFunction': ['GruvboxAqua', 'Function'],
      \ 'pythonDecorator': ['GruvboxRed', 'SpellRare'],
      \ 'pythonInclude': ['GruvboxBlue', ],
      \ 'pythonImport':  ['GruvboxBlue', ],
      \ 'pythonRun': ['GruvboxBlue', ],
      \ 'pythonCoding':  ['GruvboxBlue', ],
      \ 'pythonOperator': ['GruvboxRed', ],
      \ 'pythonExceptions':  ['GruvboxPurple', ],
      \ 'pythonBoolean': ['GruvboxPurple', ],
      \ 'pythonDot': ['GruvboxFg3', ],
      \ }

function! s:my_highlighter(style, list_of_groups)
  for group in a:list_of_groups
    if hlexists(group)
      call execute('hi! link ' . a:style . ' ' . group)
      break
    endif
  endfor
endfunction

for my_color in keys(s:my_colors)
  call s:my_highlighter(my_color, s:my_colors[my_color])
endfor
