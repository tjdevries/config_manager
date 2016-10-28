
if g:airline_enabled
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
else
    function! SetStatusline()
        let stl = ''
        let stl .= my_stl#get_mode()
        let stl .= '%*'
        let stl .= my_stl#add_left_separator()
        " let stl .= '%2*'
        let stl .= my_stl#get_file_name()
        " let stl .= '%t'
        let stl .= '%*'
        let stl .= '%='
        let stl .= '(%l,%v)'
        let stl .= '%( [%M%R%H%W]%q%)'
        let stl .= '%y'

        return stl
    endfunction

    " Set the statusline for non airline times
    set statusline=%!SetStatusline()
endif
