let g:airline_powerline_fonts=1

" TODO: Experiment a little more with some of these sections.
"   It has been a little while since you've looked.

" let g:airline_section_z = airline#section#create(['%4l', ' :%3v', gutentags#statusline('[Generating...]')]) " Only show the line & col number
let g:airline_section_z = airline#section#create(['%4l', ' :%3v']) " Only show the line & col number

let g:airline_inactive_collapse = 1 " Only indicate filename on inactive buffers
let g:airline_exclude_preview = 1 " Don't show status line in preview
let g:airline#extensions#branch#empty_message = '' " No Branch Message
let g:airline#extensions#branch#format = 2 " See documentation

" Tabline config
let g:airline#extensions#tabline#enabled = 1 " Enable Tabline integration
let g:airline#extensions#tabline#buffer_idx_mode = 1 " Leader # navigation

nnoremap <leader>at :AirlineToggle<CR>

" Set the statusline for non airline times
set statusline=%{my_stl#get_mode()}
call my_stl#add_left_separator()
set statusline+=%t
set statusline+=%(\ [%M%R%H]%)
