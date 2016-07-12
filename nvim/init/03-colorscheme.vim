syntax enable

set cursorline    " Highlight the current line

" Nyaovim configuration only
if exists("g:nyaovim_version")
    set termguicolors
endif

if g:my_current_scheme == 'gruvbox'
    let g:gruvbox_italic=1              " Turn on italics for gruvbox
    set background=dark

    colorscheme gruvbox
elseif g:my_current_scheme == 'gruvbox-tj'
    let g:gruvbox_italic=1              " Turn on italics for gruvbox
    let g:gruvbox_bold=1
    let g:gruvbox_termcolors=256
    " let g:gruvbox_improved_warnings=1
    " let g:gruvbox_improved_strings=1
    " let g:gruvbox_contrast_dark='soft'

    set background=dark
    colorscheme gruvbox-tj
elseif g:my_current_scheme == 'seoul256'
    " seoul256 (dark):
    "   Range:   233 (darkest) ~ 239 (lightest)
    "   Default: 237
    let g:seoul256_background = 234
    colo seoul256
elseif g:my_current_scheme == 'onedark'
    colorscheme onedark

    let g:airline_theme='onedark'
    let g:onedark_terminal_italics=1
elseif g:my_current_scheme == 'hybrid'
    " let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1
    set background=dark
    colorscheme hybrid
elseif g:my_current_scheme == 'base16'
    set background=dark
    let base16colorspace=256
    colorscheme base16-tomorrow
endif
