
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
    let s:show_date = v:false
    let s:show_git  = v:true

    let s:custom_filename = v:true

    function! SetStatusline()
        " Setup for variables
        let g:_active_buffer = bufnr('%')

        " Left section
        let stl = ''
        let stl .= my_stl#get_mode()
        let stl .= '%*'
        let stl .= my_stl#add_left_separator()

        if s:show_git
            let stl .= '%{my_stl#get_git()}'
        endif

        if s:custom_filename
            let stl .= '%{my_stl#get_file_name(4, 2)}'
        else
            let stl .= '%t'
        endif

        let stl .= '%( [%M%R%H%W]%q%)'
        let stl .= '%*'

        " Right section
        let stl .= '%='

        let stl .= '%{my_stl#get_tag_name()}'

        let stl .= '(%3.4l,%-3.4v)'
        let stl .= '%y'

        " let stl .= 'Active buffer: ' . string(g:_active_buffer) . ' || '
        if exists('*strftime') && s:show_date
            let stl .= ' %{strftime("%b %d")}'
        endif

        return stl
    endfunction

    " Set the statusline for non airline times
    set statusline=%!SetStatusline()

    " Small snippet for messing with statusline
    function! TestReturnHighlight()
        if &spell
            return '%#PreProc#%l%0'
        else
            return 'Not spelling and no colors'
        endif
    endfunction

    function! SetStatuslineSnippet()
        let l:str_stl = ''

        let l:str_stl .= TestReturnHighlight()

        return l:str_stl
    endfunction
    nnoremap <leader>at :set statusline=%!SetStatusline()<CR>
endif

