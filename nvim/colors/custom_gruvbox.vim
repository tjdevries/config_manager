" Colorscheme originall designed around gruvbox
call colorpal#begin()
set background=dark
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom_gruvbox'
" Not sure about this part
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#ff5555'
let g:terminal_color_2  = '#50fa7b'
let g:terminal_color_3  = '#f1fa8c'
let g:terminal_color_4  = '#bd93f9'
let g:terminal_color_5  = '#ff79c6'
let g:terminal_color_6  = '#8be9fd'
let g:terminal_color_7  = '#f8f8f2'
let g:terminal_color_8  = '#555555'
let g:terminal_color_9  = '#ff5555'
let g:terminal_color_10  = '#50fa7b'
let g:terminal_color_11  = '#f1fa8c'
let g:terminal_color_12  = '#bd93f9'
let g:terminal_color_13  = '#ff79c6'
let g:terminal_color_14  = '#8be9fd'
let g:terminal_color_15 = '#f8f8f2'

" Vim editor colors
CPHL PMenu gray4 gray2,multiply(white,20)
CPHL PMenuSel gray0 yellow,bright
CPHL PMenuSbar - gray0
CPHL PMenuThumb - gray4

CPHL Normal gray5  #282828 -
CPHL Cursor gray0 gray5 -
CPHL LineNr gray3 gray1 -
CPHL SignColumn gray3 gray1 -
CPHL EndOfBuffer gray3 - -

" Standard syntax highlighting
CPHL Comment gray3 - italic

CPHL Boolean orange,w+=20 - -
CPHL Character red - -
CPHL Conditional violet - -
CPHL Constant orange - -
CPHL Define violet - none
CPHL Delimiter brown - -
CPHL Float orange - -
CPHL Function blue,bright - -
CPHL Identifier red,light - none
CPHL Include blue - -
CPHL Keyword violet - -
CPHL Label yellow - -
CPHL Number orange - -
CPHL Operator gray5 - none
CPHL PreProc yellow - -
CPHL Repeat yellow - -
CPHL Special cyan - -
CPHL SpecialChar brown - -
CPHL Statement red - -
CPHL StorageClass yellow - -
CPHL String green - -
CPHL Structure violet - -
CPHL Tag yellow - -
CPHL Todo yellow gray1 -
CPHL Type yellow - none
CPHL Typedef yellow - -

CPHL pythonImportedObject yellow,bright,bright,c-30 - bold
CPHL pythonImportedFuncDef cyan,dark - bold
CPHL pythonImportedClassDef yellow,dark - bold,italic
