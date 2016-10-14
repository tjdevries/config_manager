function! s:Python2Syntax() 
    return ''
endfunction

" Keywords

" FIXME {{{
" Trailing space errors
" Problem: Constantly showing white space, even while typing. Very obnoxious.
" syn match pythonSpaceError	"\s\+$" display
"
" }}}

" My additions
syn match pythonSelf "\(self\.\)"
syn match pythonSelfArg "\(self\)\(\.\)\@!"

" What was here before, more or less
syn keyword pythonStatement     break continue del
syn keyword pythonStatement     exec return
syn keyword pythonStatement     pass raise
syn keyword pythonStatement     global assert
syn keyword pythonStatement     lambda
syn keyword pythonStatement     with
syn keyword pythonStatement     def class nextgroup=pythonFunction skipwhite

syn keyword pythonRepeat        for while

syn keyword pythonConditional   if elif else

syn keyword pythonException     try except finally
syn keyword pythonOperator      and in is not or

syn match pythonStatement   "\<yield\>" display
syn match pythonImport      "\<from\>" display

syn keyword pythonBoolean		True False
syn keyword pythonNone          None

" The standard pyrex.vim unconditionally removes the pythonInclude group, so
" we provide a dummy group here to avoid crashing pyrex.vim.
syn keyword pythonInclude       import
syn keyword pythonImport        import

" Decorators

syn match   pythonDecorator	"@" display nextgroup=pythonDottedName skipwhite

"
" Comments
"

syn match   pythonComment	"#.*$" display contains=pythonTodo,@Spell
syn match   pythonRun		"\%^#!.*$"

" TODO: Add something fun for TODO(tjdevries) or something like that
syn keyword pythonTodo		TODO FIXME XXX contained

"
" Errors
"

syn match pythonError		"\<\d\+\D\+\>" display
syn match pythonError		"[$?]" display
syn match pythonError		"[&|]\{2,}" display
syn match pythonError		"[=]\{3,}" display



"
" Strings
"

" Python 3 byte strings
syn region pythonBytes		start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes		start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes		start=+[bB]"""+ end=+"""+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonBytes		start=+[bB]'''+ end=+'''+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell

syn match pythonBytesError    ".\+" display contained
syn match pythonBytesContent  "[\u0000-\u00ff]\+" display contained contains=pythonBytesEscape,pythonBytesEscapeError

syn match pythonBytesEscape       +\\[abfnrtv'"\\]+ display contained
syn match pythonBytesEscape       "\\\o\o\=\o\=" display contained
syn match pythonBytesEscapeError  "\\\o\{,2}[89]" display contained
syn match pythonBytesEscape       "\\x\x\{2}" display contained
syn match pythonBytesEscapeError  "\\x\x\=\X" display contained
syn match pythonBytesEscape       "\\$"

syn match pythonUniEscape         "\\u\x\{4}" display contained
syn match pythonUniEscapeError    "\\u\x\{,3}\X" display contained
syn match pythonUniEscape         "\\U\x\{8}" display contained
syn match pythonUniEscapeError    "\\U\x\{,7}\X" display contained
syn match pythonUniEscape         "\\N{[A-Z ]\+}" display contained
syn match pythonUniEscapeError    "\\N{[^A-Z ]\+}" display contained

" Python 3 strings
syn region pythonString   start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
syn region pythonString   start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
syn region pythonString   start=+"""+ end=+"""+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonString   start=+'''+ end=+'''+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell

" Python 2/3 raw strings
syn region pythonRawString  start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString  start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString  start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
syn region pythonRawString  start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn region pythonRawBytes  start=+[bB][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawBytes  start=+[bB][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawBytes  start=+[bB][rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
syn region pythonRawBytes  start=+[bB][rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn match pythonRawEscape +\\['"]+ display transparent contained

" % operator string formatting
syn match pythonStrFormatting	"%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonRawString
syn match pythonStrFormatting	"%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonRawString

syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonRawString
syn match pythonStrFormat	"{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonRawString

syn match pythonStrTemplate	"\$\$" contained containedin=pythonString,pythonRawString
syn match pythonStrTemplate	"\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonRawString
syn match pythonStrTemplate	"\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonRawString

" DocTests
syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained

"
" Numbers (ints, longs, floats, complex)
"

syn match   pythonHexError	"\<0[xX]\x*[g-zG-Z]\x*\>" display
syn match   pythonOctError	"\<0[oO]\=\o*\D\+\d*\>" display
syn match   pythonBinError	"\<0[bB][01]*\D\+\d*\>" display

syn match   pythonHexNumber	"\<0[xX]\x\+\>" display
syn match   pythonOctNumber "\<0[oO]\o\+\>" display
syn match   pythonBinNumber "\<0[bB][01]\+\>" display

syn match   pythonNumberError	"\<\d\+\D\>" display
syn match   pythonNumberError	"\<0\d\+\>" display
syn match   pythonNumber	"\<\d\>" display
syn match   pythonNumber	"\<[1-9]\d\+\>" display
syn match   pythonNumber	"\<\d\+[jJ]\>" display

syn match   pythonOctError	"\<0[oO]\=\o*[8-9]\d*\>" display
syn match   pythonBinError	"\<0[bB][01]*[2-9]\d*\>" display

syn match   pythonFloat		"\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

"
" Builtin objects and types
"


syn keyword pythonBuiltinObj	Ellipsis NotImplemented
syn keyword pythonBuiltinObj	__debug__ __doc__ __file__ __name__ __package__

"
" Builtin functions
"

syn keyword pythonBuiltinFunc	ascii exec memoryview print

syn keyword pythonBuiltinFunc	__import__ abs all any
syn keyword pythonBuiltinFunc	bin bool bytearray bytes
syn keyword pythonBuiltinFunc	chr classmethod cmp compile complex
syn keyword pythonBuiltinFunc	delattr dict dir divmod enumerate eval
syn keyword pythonBuiltinFunc	filter float format frozenset getattr
syn keyword pythonBuiltinFunc	globals hasattr hash hex id
syn keyword pythonBuiltinFunc	input int isinstance
syn keyword pythonBuiltinFunc	issubclass iter len list locals map max
syn keyword pythonBuiltinFunc	min next object oct open ord
syn keyword pythonBuiltinFunc	pow property range
syn keyword pythonBuiltinFunc	repr reversed round set setattr
syn keyword pythonBuiltinFunc	slice sorted staticmethod str sum super tuple
syn keyword pythonBuiltinFunc	type vars zip

"
" Builtin exceptions and warnings
"

syn keyword pythonExClass	BlockingIOError ChildProcessError
syn keyword pythonExClass	ConnectionError BrokenPipeError
syn keyword pythonExClass	ConnectionAbortedError ConnectionRefusedError
syn keyword pythonExClass	ConnectionResetError FileExistsError
syn keyword pythonExClass	FileNotFoundError InterruptedError
syn keyword pythonExClass	IsADirectoryError NotADirectoryError
syn keyword pythonExClass	PermissionError ProcessLookupError TimeoutError

syn keyword pythonExClass	ResourceWarning
syn keyword pythonExClass	BaseException
syn keyword pythonExClass	Exception ArithmeticError
syn keyword pythonExClass	LookupError EnvironmentError

syn keyword pythonExClass	AssertionError AttributeError BufferError EOFError
syn keyword pythonExClass	FloatingPointError GeneratorExit IOError
syn keyword pythonExClass	ImportError IndexError KeyError
syn keyword pythonExClass	KeyboardInterrupt MemoryError NameError
syn keyword pythonExClass	NotImplementedError OSError OverflowError
syn keyword pythonExClass	ReferenceError RuntimeError StopIteration
syn keyword pythonExClass	SyntaxError IndentationError TabError
syn keyword pythonExClass	SystemError SystemExit TypeError
syn keyword pythonExClass	UnboundLocalError UnicodeError
syn keyword pythonExClass	UnicodeEncodeError UnicodeDecodeError
syn keyword pythonExClass	UnicodeTranslateError ValueError VMSError
syn keyword pythonExClass	WindowsError ZeroDivisionError

syn keyword pythonExClass	Warning UserWarning BytesWarning DeprecationWarning
syn keyword pythonExClass	PendingDepricationWarning SyntaxWarning
syn keyword pythonExClass	RuntimeWarning FutureWarning
syn keyword pythonExClass	ImportWarning UnicodeWarning

if ''
  syn sync minlines=2000
else
  " This is fast but code inside triple quoted strings screws it up. It
  " is impossible to fix because the only way to know if you are inside a
  " triple quoted string is to start from the beginning of the file.
  syn sync match pythonSync grouphere NONE "):$"
  syn sync maxlines=200
endif

if v:version >= 508 || !exists('did_python_syn_inits')
  if v:version <= 508
    let did_python_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pythonStatement        Statement
  HiLink pythonImport           Include
  HiLink pythonFunction         Function
  HiLink pythonConditional      Conditional
  HiLink pythonRepeat           Repeat
  HiLink pythonException        Exception
  HiLink pythonOperator         Operator

  HiLink pythonDecorator        Define
  HiLink pythonDottedName       Comment
  HiLink pythonDot              Normal

  HiLink pythonComment          Comment
  HiLink pythonCoding           Special
  HiLink pythonRun              Special
  HiLink pythonTodo             Todo

  HiLink pythonError            Error
  HiLink pythonIndentError      Error
  HiLink pythonSpaceError       Error

  HiLink pythonString           String
  HiLink pythonRawString        String

  HiLink pythonUniEscape        Special
  HiLink pythonUniEscapeError   Error

  HiLink pythonStrFormatting    Special
  HiLink pythonStrFormat        Special
  HiLink pythonStrTemplate      Special

  HiLink pythonDocTest          Special
  HiLink pythonDocTest2         Special

  HiLink pythonNumber           Number
  HiLink pythonHexNumber        Number
  HiLink pythonOctNumber        Number
  HiLink pythonBinNumber        Number
  HiLink pythonFloat            Float
  HiLink pythonNumberError      Error
  HiLink pythonOctError         Error
  HiLink pythonHexError         Error
  HiLink pythonBinError         Error

  HiLink pythonBoolean          Boolean

  " HiLink pythonBuiltinObj       Structure
  " HiLink pythonBuiltinFunc      Function

  HiLink pythonExClass          Structure

  delcommand HiLink
endif

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


" Maybe I could include colorpal with this
" call tj#highlight_customize(s:my_colors)

