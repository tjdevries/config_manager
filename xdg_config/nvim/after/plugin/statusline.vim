if get(g:, 'demo')
    finish
endif

let g:_show_date = v:true
let g:_show_git  = v:true
let g:_custom_filename = v:true

function! SetStatusline() abort
    " Setup for variables
    let g:_active_buffer = bufnr('%')

    " Left section
    let stl = ''
    let stl .= my_stl#get_mode()
    let stl .= '%*'
    let stl .= my_stl#add_left_separator()

    if g:_show_git
        let stl .= '%{my_stl#get_git()}'
    endif

    if g:_custom_filename
        " let stl .= bufnr('%') . ' ' . bufnr(0) . ' ' . nvim_buf_get_number(0) . ' '
        " let stl .= '%{#my_stl#get_file_hightlight(bufnr("%"))}'
        let stl .='%{my_stl#get_warehouse_dlg()}'

        let stl .= '%{my_stl#get_file_name(4, 2)}'
        let stl .= '%*'
    else
        let stl .= '%t'
    endif

    let stl .= '%( [%M%R%H%W]%q%)'
    let stl .= '%*'

    let stl .= '%{my_stl#get_current_func()}'

    " Right section
    let stl .= '%='

    let stl .= '%{my_stl#coc_status()}'
    let stl .= '%{my_stl#get_tag_name()}'

    let stl .= &diff ? '[d]' : ''

    let stl .= '(%3.4l,%-3.4v)'
    let stl .= '%y'

    " let stl .= 'Active buffer: ' . string(g:_active_buffer) . ' || '
    if exists('*strftime') && g:_show_date
        let stl .= ' %{strftime("%b %d, %H:%M")}'
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
