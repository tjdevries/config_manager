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


call tj#highlight_customize(s:my_colors)
