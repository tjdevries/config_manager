" Vi  plugin for defining and viewing your maps
" Maintainer: TJ DeVries
" Thanks to Damian Conway for the idea

" if exists("g:loaded_descriptive_maps")
"     finish
" endif
let g:loaded_descriptive_maps = 1

" let g:descriptive_maps = get(g:, 'descriptive_maps', {})
let g:descriptive_maps = {}
let s:_map_arguments = [
            \ "<buffer>",
            \ "<nowait>",
            \ "<silent>",
            \ "<special>",
            \ "<script>",
            \ "<expr>",
            \ "<unique>"
            \ ]

let g:_description_separator = ">>>"

function! s:describe(command_string)
    let l:cmd_split = split(a:command_string)

    let l:map_command = l:cmd_split[0]
    let l:map_args = []

    let l:ind = 1
    while (l:ind < len(l:cmd_split)) && (index(s:_map_arguments, l:cmd_split[l:ind]) >= 0)
        call add(l:map_args, l:cmd_split[l:ind])
        let l:ind = l:ind + 1
    endwhile

    let l:lhs = l:cmd_split[l:ind]

    let l:description_split_location = index(l:cmd_split, g:_description_separator)
    if l:description_split_location >= 0
        let l:rhs = join(l:cmd_split[l:ind + 1: l:description_split_location - 1], ' ')
        let l:description = join(l:cmd_split[l:description_split_location + 1:], ' ')
    else
        let l:rhs = join(l:cmd_split[l:ind + 1:], ' ')
        let l:description = "Undocumented"
    endif

    call s:_handle_arguments(l:map_command, l:map_args, l:lhs, l:rhs, l:description)
endfunction


function! s:_handle_arguments(map_command, map_args, lhs, rhs, description)
    " echom a:map_command . a:map_args . a:lhs . a:rhs . a:description

    let g:descriptive_maps[a:map_command] = get(g:descriptive_maps, 'a:map_command', {})
    let g:descriptive_maps[a:map_command][a:lhs] = {
                \ 'rhs': a:rhs,
                \ 'description': a:description,
                \ 'args': a:map_args
                \ }

    let g:last_handled = a:map_command  . " " . join(a:map_args, ' ') . " " . a:lhs . " " . a:rhs
    execute g:last_handled
endfunction

function! s:show_description()
    echo g:descriptive_maps
endfunction

command! -nargs=1 Describe call <SID>describe(<f-args>)

Describe nmap <silent> <leader>h :call <SID>show_description()<CR> >>> Show_cool_stuff hello
Describe nnoremap <leader>x :echo("hello")<CR>
