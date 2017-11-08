" Colorscheme originally designed around gruvbox
call colorpal#begin()
set background=dark
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom_gruvbox'

" Standard syntax highlighting {{{
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
CPHL Statement red - -
CPHL StorageClass yellow - -
CPHL String green - -
CPHL Structure violet - -
CPHL Tag yellow - -
CPHL Todo yellow gray1 -
CPHL Type yellow - none
CPHL Typedef yellow - -
" }}}


" {{{ Diff itms
CPHL gitDiff gray6,dark,dark,dark - none

CPHL DiffChange - gray7,subtract(red,100),dark -
CPHL DiffText - red italic
CPHL DiffDelete gray3 gray0
CPHL DiffAdded green,dark,dark none none
CPHL DiffRemoved red,bright none none
" }}}
" {{{ Function items
CPHL Function yellow - - bold
CPHL pythonBuiltinFunc Function,dark,dark Function Function
CPHL vimFunction Function Function Function
CPHL vimAutoloadFunction Function,dark,dark Function -
" }}}
" {{{ Folded items
CPHL Folded gray3,dark gray2,light - -
" }}}
" {{{ Grepper colors
highlight Directory
  \ ctermfg=216 ctermbg=NONE cterm=NONE guifg=#ffaf87 guibg=NONE gui=NONE
highlight qfLineNr
  \ ctermfg=238 ctermbg=NONE cterm=NONE guifg=#444444 guibg=NONE gui=NONE
highlight qfSeparator
  \ ctermfg=243 ctermbg=NONE cterm=NONE guifg=#767676 guibg=NONE gui=NONE
" }}}
" {{{ Impsort & Braceless highlights
CPHL pythonImportedObject red,dark - bold
CPHL pythonImportedFuncDef pythonBuiltinFunc,add(cyan,50) - bold
CPHL pythonImportedClassDef yellow,dark - bold,italic
CPHL pythonImportedModule red,bright - bold

CPHL BracelessIndent gray7,bright gray7,bright
" }}}
" {{{ Parenth items
CPHL MatchParen cyan gray0 - -
" }}}
" {{{ Python items
CPHL pythonSelf violet,bright - - 
CPHL pythonSelfArg gray3 - italic
CPHL pythonOperator red - none

CPHL pythonNone red,bright - -
CPHL pythonBytes green - italic
CPHL pythonRawBytes green - italic
CPHL pythonBytesContent green - italic
CPHL link pythonBytesError Error
CPHL link pythonBytesEscape Special
CPHL link pythonBytesEscapeError Error
" }}}
" {{{ Searching
CPHL Search gray1 yellow none
" }}}
" Sneak colors {{{
CPHL SneakPluginTarget blue,bright black,dark,dark,dark,dark bold
" }}}
" Special characters {{{
CPHL Special cyan - -
CPHL SpecialChar brown - -
CPHL SpecialKey gray7,l+=0.99 - -
CPHL NonText gray2 - -
CPHL Whitespace gray7 - -

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
" Statusline Colors {{{
" Primary Statusline Colors
CPHL StatusLine gray2 blue -
CPHL StatusLineNC gray3 gray1
CPHL User1 gray7 yellow bold
CPHL User2 gray7 red bold
CPHL User3 gray7 green bold
CPHL CommandMode gray7 green bold
CPHL NormalMode gray7 red bold
CPHL InsertMode gray7 yellow bold
" TODO: Get the templating thing to work with InsertMode
CPHL ReplaceMode gray7 yellow bold,underline
CPHL TerminalMode gray7 turquoise bold
CPHL HelpDoc gray7 turquoise bold,italic

" TODO: Template or make these slightly different or something
let s:visual_color = ' - blue,dark,dark,dark,dark -'
call execute('CPHL Visual' . s:visual_color)
call execute('CPHL VisualMode ' . s:visual_color)
call execute('CPHL VisualLineMode' . s:visual_color)
" {{{ Color printer help
function! g:Color_printer() abort
  for color_name in keys(g:colorpal_pallette)
    execute('CPHL Temp ' . color_name . ' ' . color_name . ' - -')
    echon color_name . ': ' | echohl Temp | echon color_name | echohl None | echon "\n"
  endfor
endfunction
" }}}
" {{{ HTML & Markdown
CPHL htmlH1 blue,dark - bold
" }}}
" }}}
" Tab line {{{
CPHL TabLine white gray1,add(white,30) none
CPHL TabLineFill white gray7,bright,bright,bright
CPHL TablineSel white,bright gray1,bright bold
" }}}
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
" {{{ Typescript
CPHL TypeScriptReserved red - italic
" }}}
" Ultisnips {{{
CPHL snipLeadingSpaces gray1 - -
" }}}
" Vim Editor {{{
CPHL PMenu gray4 gray2,multiply(white,20)
CPHL PMenuSel gray0 yellow,bright
CPHL PMenuSbar - gray0
CPHL PMenuThumb - gray4

" Can't figure out why this won't accept dark... oh well
CPHL Normal gray5 gray0 -
" Sometimes cursorline just does it's own thing?...
CPHL CursorLine - Normal,bright,bright -
highlight CursorLine cterm=bold
CPHL Cursor gray0 gray5 -
CPHL LineNr gray3 gray1 -
CPHL SignColumn gray3 gray1 -
CPHL EndOfBuffer gray3 - -
" }}}
" Vim Syntax {{{
CPHL vimNotFunc blue - -
CPHL vimCommand blue - -
CPHL vimLet purple,light - -
CPHL VimFuncVar purple
CPHL VimIsCommand softwhite
CPHL vimCommentTitle red - bold
" Vimrc items {{{
CPHL vimMapModKey cyan - -
CPHL vimNotation cyan - -
CPHL vimMapLHS yellow - -
CPHL vimBracket cyan,negative - -
CPHL vimMap darkseagreen4 - -
CPHL nvimMap vimMap - -
" }}}
" CPHL items {{{
CPHL CPHLBlank yellow,s-=.5 - -
CPHL CPHLMod purple,s+=.5 - -
" }}}
" }}}
" {{{ Vimwiki Syntax
CPHL VimwikiBold red - bold
" }}}
