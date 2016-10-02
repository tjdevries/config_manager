syntax enable

set cursorline    " Highlight the current line

" Nyaovim configuration only
if exists('g:nyaovim_version')
    set termguicolors
endif

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
