" Vi  plugin for defining and viewing your maps
" Maintainer: TJ DeVries
" Thanks to Damian Conway for the idea

"" Use like this in your vimrc after sourcing
" Describe nmap <silent> <leader>h :call <SID>show_description()<CR> >>> Show_cool_stuff hello
" Describe nnoremap <leader>x :echo("hello")<CR>
""

" if exists("g:loaded_descriptive_maps")
"     finish
" endif
let g:loaded_descriptive_maps = 1

" let g:descriptive_maps = get(g:, 'descriptive_maps', {})
let s:_map_arguments = [
            \ '<buffer>',
            \ '<nowait>',
            \ '<silent>',
            \ '<special>',
            \ '<script>',
            \ '<expr>',
            \ '<unique>'
            \ ]
let s:_tracked_descriptors = [
            \ 'mode',
            \ 'lhs',
            \ 'rhs',
            \ 'description',
            \ 'args',
            \ 'executed',
            \ ]

let g:descriptive_maps       = get(g: , 'descriptive_maps'       , {})
let g:_description_execute   = get(g: , '_description_execute'   , v:true)
let g:_description_separator = get(g: , '_description_separator' , '>>>')
let g:_description_unknown   = get(g: , '_description_unknown'   , 'Undocumented')

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
        let l:description = g:_description_unknown
    endif

    call s:_handle_arguments(l:map_command, l:map_args, l:lhs, l:rhs, l:description)
endfunction


function! s:_handle_arguments(map_command, map_args, lhs, rhs, description)
    " echom a:map_command . a:map_args . a:lhs . a:rhs . a:description

    let g:descriptive_maps[a:map_command] = get(g:descriptive_maps, 'a:map_command', {})
    let g:descriptive_maps[a:map_command][a:lhs] = {
                \ 'mode': a:map_command,
                \ 'lhs': a:lhs,
                \ 'rhs': a:rhs,
                \ 'description': a:description,
                \ 'args': a:map_args,
                \ 'executed': g:_description_execute,
                \ }

    let g:last_handled = a:map_command  . ' ' . join(a:map_args, ' ') . ' ' . a:lhs . ' ' . a:rhs

    if g:_description_execute
        execute g:last_handled
    endif
endfunction

""
" Return information required about the various commands
" For each characteristic, it returns:
"   max_length (int): the longest string in the category
function! s:understand(maps)
    let l:understood = {}
    for l:tracked in s:_tracked_descriptors
        let l:understood[l:tracked] = {}
        let l:understood[l:tracked]['max_length'] = 0
    endfor

    " Find the max length
    for l:mode in keys(g:descriptive_maps)
        let l:maps = keys(g:descriptive_maps[l:mode])

        for l:map in l:maps
            for l:tracked in s:_tracked_descriptors
                try
                    let l:current_length = len(g:descriptive_maps[l:mode][l:map][l:tracked])
                catch
                    let l:current_length = 7
                endtry
                    
                " TODO: Handle args correctly
                let l:understood[l:tracked]['max_length'] = max([
                            \ l:understood[l:tracked]['max_length'],
                            \ l:current_length
                            \ ])
            endfor
        endfor
    endfor

    return l:understood
endfunction

function! s:format_line(description, mode, lhs, rhs, understood)
    let l:format = printf(
                \ '%' . a:understood['description']['max_length'] . 's' .
                \ ': ' .
                \ '%' . a:understood['mode']['max_length'] . 's | ' .
                \ '%' . a:understood['lhs']['max_length'] . 's  --> ' .
                \ '%' . a:understood['rhs']['max_length'] . 's' .
                \ '',
                \ a:description, a:mode, a:lhs, a:rhs
                \ )

    return l:format
endfunction

function! s:get_formatted_lines()
    let l:understood = s:understand(g:descriptive_maps)

    let l:lines = []

    for l:mode in sort(copy(keys(g:descriptive_maps)))
        let l:maps = sort(keys(g:descriptive_maps[l:mode]))

        for l:map in l:maps
            let l:temp = g:descriptive_maps[l:mode][l:map]
            call add(l:lines, s:format_line(
                        \ l:temp['description'],
                        \ l:temp['mode'],
                        \ l:temp['lhs'],
                        \ l:temp['rhs'],
                        \ l:understood
                        \ ))
        endfor
    endfor

    return l:lines
endfunction



function! Show_description()
    let l:lines = []

    let l:understood = s:understand(g:descriptive_maps)
    " echo l:understood

    call add(l:lines, s:format_line('Description', 'mode', 'lhs', 'rhs', l:understood))
    call add(l:lines, repeat('-', len(s:format_line('Description', 'mode', 'lhs', 'rhs', l:understood))))

    call extend(l:lines, s:get_formatted_lines())


    for l:line in l:lines
        echo l:line
    endfor

    return l:lines
endfunction

Describe nnoremap <leader>x :echo("hello")<CR>
Describe nmap <silent> <leader>h :echo("WOW! SO COOL!")<CR> >>> Tells me something
Describe vmap h :echo('vmap')<CR> >>> Another description

command! -nargs=1 Describe call <SID>describe(<f-args>)
" command! -nargs=0 ShowDescription call <SID>show_description()
" command! -nargs=0 ShowDescription call Show_description()
