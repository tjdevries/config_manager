syntax enable
" Nyaovim configuration only
if exists('g:nyaovim_version')
    set termguicolors
endif

let g:my_current_scheme = 'custom_gruvbox'

" {{{1 Old
if g:my_current_scheme ==? 'gruvbox'
    let g:gruvbox_italic=1              " Turn on italics for gruvbox
    set background=dark

    colorscheme gruvbox
elseif g:my_current_scheme ==? 'gruvbox-tj'
    let g:gruvbox_italic=1              " Turn on italics for gruvbox
    let g:gruvbox_bold=1
    let g:gruvbox_termcolors=256
    " let g:gruvbox_improved_warnings=1
    " let g:gruvbox_improved_strings=1
    " let g:gruvbox_contrast_dark='soft'

    set background=dark
    colorscheme gruvbox-tj
" {{{1 Custom Gruvbox
elseif g:my_current_scheme ==? 'custom_gruvbox'

  let s:load_palette = 'tomorrow'

  " TODO: Experiment with this more :)
  " let s:load_palette = 'seabird_petrel'

  " {{{2 Gruvbox
  let g:gruvbox_palette = {
    \
    \ 'black'     : '282828',
    \ 'gray0'     : '1d1f21',
    \ 'gray1'     : '282828',
    \ 'gray2'     : '373b41',
    \ 'gray3'     : '969896',
    \ 'gray4'     : 'b4b7b4',
    \ 'gray5'     : 'c5c8c6',
    \ 'gray6'     : 'e0e0e0',
    \ 'gray7'     : 'ffffff',
    \ 'white'     : 'f2e5bc',
    \
    \ 'red'       : 'fb4934',
    \ 'green'     : '2acf2a',
    \ 'yellow'    : 'fabd2f',
    \ 'blue'      : '83a598',
    \ 'aqua'      : '8ec07c',
    \ 'cyan'      : '8abeb7',
    \ 'purple'    : 'd3869b',
    \ 'violet'    : 'b294bb',
    \ 'orange'    : 'fe8019',
    \ 'brown'     : 'a3685a',
    \
    \ 'softwhite' : 'ebdbb2',
  \ }

  " {{{2 Tomorrow
  let g:tomorrow_palette = {
    \
    \ 'black'     : '1d1f21',
    \ 'gray0'     : '1d1f21',
    \ 'gray1'     : '282a2e',
    \ 'gray2'     : '373b41',
    \ 'gray3'     : '969896',
    \ 'gray4'     : 'b4b7b4',
    \ 'gray5'     : 'c5c8c6',
    \ 'gray6'     : 'e0e0e0',
    \ 'gray7'     : 'ffffff',
    \ 'white'     : 'f2e5bc',
    \
    \ 'red'       : 'cc6666',
    \ 'green'     : '99cc99',
    \ 'yellow'    : 'f0c674',
    \ 'blue'      : '81a2be',
    \ 'aqua'      : '8ec07c',
    \ 'cyan'      : '8abeb7',
    \ 'purple'    : '8e6fbd',
    \ 'violet'    : 'b294bb',
    \ 'orange'    : 'de935f',
    \ 'brown'     : 'a3685a',
    \
    \ 'softwhite' : 'ebdbb2',
  \ }

  " {{{2 Seabird
  let g:seabird_palette = {
        \ 'black': '1d1f21',
        \ 'gray0': '1d1f21',
        \ 'gray1': '0b141a',
        \ 'gray2': '1d252b',
        \ 'gray3': '61707a',
        \ 'gray4': '6d767d',
        \ 'gray5': '787e82',
        \ 'gray6': '808487',
        \ 'gray7': 'e6eaed',
        \
        \ 'red': 'ff4053',
        \ 'orange': 'ff6200',
        \ 'yellow': 'bf8c00',
        \ 'green': '11ab00',
        \ 'teal': '00a5ab',
        \ 'blue': '0099ff',
        \ 'purple': '9854ff',
        \ 'pink': 'ff549b',
      \ }

  " {{{2 Seabird petrel
  let g:seabird_petrel_palette = {
        \ 'black': '1d1f21',
        \ 'gray0': '1d1f21',
        \ 'gray1': '0b141a',
        \ 'gray2': '1d252b',
        \ 'gray3': '61707a',
        \ 'gray4': '6d767d',
        \ 'gray5': '787e82',
        \ 'gray6': '808487',
        \ 'gray7': 'e6eaed',
        \
        \ 'red':    'ba656d',
        \ 'orange': 'b06d43',
        \ 'yellow': '947b38',
        \ 'green':  '3f8f36',
        \ 'teal':   '35898c',
        \ 'blue':   '4384b0',
        \ 'purple': '8e6fbd',
        \ 'pink':   '947b38',
        \ 'violet': '9854ff',
        \
        \ 'aqua': '0099ff',
        \ 'cyan': '00a5ab',
        \
      \ }



  " Register to set the values:
  " f#lyw34jf'"_d$A'pA'€kb€kb'33k^

  " Setup {{{2 Paletton
  let g:paletton_palette = copy(g:tomorrow_palette)
  " Primary color:

   let g:paletton_palette.red = 'EC5040'
   let g:paletton_palette.red0 = 'FFBCB5'
   let g:paletton_palette.red1 = 'FF8174'
   let g:paletton_palette.red2 = 'C22414'
   let g:paletton_palette.red3 = '850D00'

  " Secondary color (1):

   let g:paletton_palette.orange = 'EC9440'
   let g:paletton_palette.orange0 = 'FFD9B5'
   let g:paletton_palette.orange1 = 'FFB874'
   let g:paletton_palette.orange2 = 'C26914'
   let g:paletton_palette.orange3 = '854100'

  " Secondary color (2):

   let g:paletton_palette.blue = '2A8192'
   let g:paletton_palette.blue0 = '9DD2DC'
   let g:paletton_palette.blue1 = '51A0AE'
   let g:paletton_palette.blue2 = '0F6777'
   let g:paletton_palette.blue3 = '024552'

  " Complement color:

   let g:paletton_palette.green = '30B34D'
   let g:paletton_palette.green0 = 'A5E9B4'
   let g:paletton_palette.green1 = '5DCC75'
   let g:paletton_palette.green2 = '0F922C'
   let g:paletton_palette.green3 = '006516'

  " {{{2 Setup
  let g:colorpal_palette = g:{s:load_palette}_palette


  let g:colorpal_airline = {
        \ 'normal': [['#282828', 'green'], ['gray6', 'gray2'], ['green,light', 'gray1']],
        \ 'insert': [['gray1', 'cyan'], ['gray6', 'gray2'], ['orange', 'gray1']],
        \ 'replace': [['gray1', 'red'], ['gray6', 'gray2'], ['orange', 'gray1']],
        \ 'visual': [['gray1', 'violet'], ['gray6', 'gray2'], ['orange', 'gray1']],
        \ 'inactive': [['gray7', 'gray2'], ['gray7', 'gray2'], ['gray7', 'gray2']],
  \ }

  colorscheme custom_gruvbox
" {{{1 More old
elseif g:my_current_scheme ==? 'tender'
    set termguicolors
    set background=dark

    let g:airline_theme = 'tender'
    colorscheme tender
elseif g:my_current_scheme ==? 'seoul256'
    " seoul256 (dark):
    "   Range:   233 (darkest) ~ 239 (lightest)
    "   Default: 237
    let g:seoul256_background = 234
    colo seoul256
elseif g:my_current_scheme ==? 'onedark'
    let g:airline_theme='onedark'
    let g:onedark_terminal_italics = 1

    set background=dark
    colorscheme onedark
elseif g:my_current_scheme ==? 'hybrid'
    " let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1
    set background=dark
    colorscheme hybrid
elseif g:my_current_scheme ==? 'base16'
    set background=dark
    let base16colorspace=256
    colorscheme base16-tomorrow
endif

" Thanks to Justinmk for this.
" Not currently using it though. I want to change some of the colors to make
" it work my colorschemes more. And maybe have it wait until multiple presses.
let g:halo_enabled = v:false

if g:halo_enabled == v:true
  highlight Halo guibg=#F92672 ctermbg=197
  let g:halo = {}
  function! s:halo_clear(id) abort
    silent! call timer_stop(g:halo['timer_id'])
    silent! call matchdelete(g:halo['hl_id'])
  endfunction
  function! s:halo() abort
    call s:halo_clear(-1)
    let g:halo['hl_id'] = matchaddpos('Halo',
          \[[line('.'),   col('.')-10, 20],
          \ [line('.')-1, col('.')-10, 20],
          \ [line('.')-2, col('.')-10, 20],
          \ [line('.')+1, col('.')-10, 20],
          \ [line('.')+2, col('.')-10, 20]]
          \)
    let g:halo['timer_id'] = timer_start(1000, function('s:halo_clear'))
  endfunction
  augroup halo_plugin
    autocmd!
    autocmd WinLeave * call <SID>halo_clear(-1)
  augroup END
  nnoremap <silent> <Esc> :call <SID>halo()<CR>
endif

function! SyntaxNames() abort
  let l:syntax_list = []
  for id in synstack(line('.'), col('.'))
    call add(l:syntax_list, synIDattr(id, 'name'))
  endfor

  return l:syntax_list
endfunction

function! NewSyntaxNames() abort
  let l:syntax_list = []
  for id in synstack(line('.'), col('.'))
    call add(l:syntax_list, synIDattr(synIDtrans(id), 'name'))
  endfor

  return l:syntax_list
endfunction

" Syntax help
nnoremap <leader>sh :echo string(SyntaxNames())<CR>
nnoremap <leader><leader>sh :echo string(NewSyntaxNames())<CR>
