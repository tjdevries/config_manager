syntax enable

set cursorline    " Highlight the current line

" Nyaovim configuration only
if exists('g:nyaovim_version')
    set termguicolors
endif

let g:my_current_scheme = 'custom_gruvbox'

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
elseif g:my_current_scheme ==? 'custom_gruvbox'
  let s:load_palette = 'tomorrow'

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
    \ 'green'     : 'b8bb26',
    \ 'yellow'    : 'fabd2f',
    \ 'blue'      : '83a598',
    \   'aqua'    : '8ec07c',
    \   'cyan'    : '8abeb7',
    \ 'purple'    : 'd3869b',
    \   'violet'  : 'b294bb',
    \ 'orange'    : 'fe8019',
    \ 'brown'     : 'a3685a',
    \
    \ 'softwhite' : 'ebdbb2',
  \ }

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
    \ 'green'     : 'b5bd68',
    \ 'yellow'    : 'f0c674',
    \ 'blue'      : '81a2be',
    \   'aqua'    : '8ec07c',
    \   'cyan'    : '8abeb7',
    \ 'purple'    : 'd3869b',
    \   'violet'  : 'b294bb',
    \ 'orange'    : 'de935f',
    \ 'brown'     : 'a3685a',
    \
    \ 'softwhite' : 'ebdbb2',
  \ }


  let g:colorpal_palette = g:{s:load_palette}_palette


  let g:colorpal_airline = {
        \ 'normal': [['#282828', 'green'], ['gray6', 'gray2'], ['green,light', 'gray1']],
        \ 'insert': [['gray1', 'cyan'], ['gray6', 'gray2'], ['orange', 'gray1']],
        \ 'replace': [['gray1', 'red'], ['gray6', 'gray2'], ['orange', 'gray1']],
        \ 'visual': [['gray1', 'violet'], ['gray6', 'gray2'], ['orange', 'gray1']],
        \ 'inactive': [['gray7', 'gray2'], ['gray7', 'gray2'], ['gray7', 'gray2']],
  \ }

  colorscheme custom_gruvbox
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

" Syntax help
nnoremap <leader>sh :echo string(SyntaxNames())<CR>
