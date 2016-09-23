
" I've added:

if hlexists('GruvboxPurpleItalic')
  hi! link pythonSelf GruvboxPurpleItalic
else
  hi! link pythonSelf Constant
endif

if hlexists('GruvboxGrayItalic')
  hi! link pythonSelfArg GruvboxGrayItalic
else
  hi! link pythonSelfArg Comment
endif

hi! link pythonNone GruvboxBlueSign

if hlexists('GruvboxBlueSign')
  hi! link pythonImportedObject GruvboxBlueSign
else
  hi! link pythonImportedObject PreProc
endif
