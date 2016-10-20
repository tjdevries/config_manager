" Colorscheme originall designed around gruvbox
call colorpal#begin()
set background=dark
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom_gruvbox'
" {{{ Terminal colors
" *.foreground:   #c5c8c6
" *.background:   #1d1f21
" *.cursorColor:  #c5c8c6

" black
let g:terminal_color0 = '#282a2e'
let g:terminal_color8 = '#373b41'

" red
let g:terminal_color1 = '#a54242'
let g:terminal_color9 = '#cc6666'

" green
let g:terminal_color2 = '#8c9440'
let g:terminal_color10 = '#b5bd68'

" yellow
let g:terminal_color3 = '#de935f'
let g:terminal_color11 = '#f0c674'

" blue
let g:terminal_color4 = '#5f819d'
let g:terminal_color12 = '#81a2be'

" magenta
let g:terminal_color5 = '#85678f'
let g:terminal_color13 = '#b294bb'

" cyan
let g:terminal_color6 = '#5e8d87'
let g:terminal_color14 = '#8abeb7'

" white
let g:terminal_color7 = '#707880'
let g:terminal_color15 = '#c5c8c6'
" }}}

" Vim editor colors
CPHL PMenu gray4 gray2,multiply(white,20)
CPHL PMenuSel gray0 yellow,bright
CPHL PMenuSbar - gray0
CPHL PMenuThumb - gray4

" Can't figure out why this won't accept dark... oh well
CPHL Normal gray5 #282828 -
CPHL Cursor gray0 gray5 -
CPHL LineNr gray3 gray1 -
CPHL SignColumn gray3 gray1 -
CPHL EndOfBuffer gray3 - -

" Standard syntax highlighting
CPHL Comment gray3 - italic

CPHL Boolean orange,w+=20 - -
CPHL Character red - -
CPHL Conditional red - -
CPHL Constant orange - -
CPHL Define cyan - none
CPHL Delimiter brown - -
CPHL Float orange - -
CPHL Identifier red,light - none
CPHL Include cyan - -
CPHL Keyword violet - -
CPHL Label yellow - -
CPHL Number orange - -
CPHL Operator red,bright,bright,bright - -
CPHL PreProc yellow - -
CPHL Repeat red - -
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

" {{{ Impsort & Braceless highlights
CPHL pythonImportedObject red,dark - bold
CPHL pythonImportedFuncDef cyan,dark - bold
CPHL pythonImportedClassDef yellow,dark - bold,italic
CPHL pythonImportedModule red,bright - bold

CPHL BracelessIndent gray7,bright gray7,bright
" }}}
" {{{ Function items
CPHL Function blue,bright - bold
CPHL pythonBuiltinFunc blue - bold
" }}}
" {{{ Python items
CPHL pythonSelf violet,bright - - 
CPHL pythonSelfArg gray3 - italic
CPHL pythonOperator red - none

CPHL python None red,bright - -
CPHL pythonBytes green - italic
CPHL pythonRawBytes green - italic
CPHL pythonBytesContent green - italic
CPHL link pythonBytesError Error
CPHL link pythonBytesEscape Special
CPHL link pythonBytesEscapeError Error
" }}}
" {{{ Parenth items
CPHL MatchParen gray0 gray7 - -
" }}}
" {{{ Folded items
CPHL Folded gray0 gray5 - -
" }}}
" {{{ Startify
CPHL StartifyBracket red - -
CPHL StartifyFile red,dark - -
CPHL StartifyNumber blue - -
CPHL StartifyPath green,dark - -
CPHL StartifySlash cyan - bold
CPHL StartifySection yellow,bright - -
CPHL StartifySpecial orange - -
CPHL StartifyHeader orange - -
CPHL StartifyFooter gray2 - -
" }}}
" {{{ Diff items
CPHL DiffAdd - #008000 none
CPHL DiffChange - gray7,subtract(red,100),dark -
CPHL DiffText - red italic
CPHL DiffDelete gray3 gray0
" }}}
" {{{ Grepper colors
highlight Directory
  \ ctermfg=216 ctermbg=NONE cterm=NONE guifg=#ffaf87 guibg=NONE gui=NONE
highlight qfLineNr
  \ ctermfg=238 ctermbg=NONE cterm=NONE guifg=#444444 guibg=NONE gui=NONE
highlight qfSeparator
  \ ctermfg=243 ctermbg=NONE cterm=NONE guifg=#767676 guibg=NONE gui=NONE
" }}}
" {{{ Color printer help
function! g:Color_printer() abort
  for color_name in keys(g:colorpal_pallette)
    execute('CPHL Temp ' . color_name . ' ' . color_name . ' - -')
    echon color_name . ': ' | echohl Temp | echon color_name | echohl None | echon "\n"
  endfor
endfunction
" }}}
