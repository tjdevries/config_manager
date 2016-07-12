" Vim plugin for defining and viewing your maps
" Maintainer: TJ DeVries
" Thanks to Damian Conway for the idea

" if exists("g:loaded_descriptive_maps")
"     finish
" endif
let g:loaded_descriptive_maps = 1

let g:descriptive_maps = get(g:, 'descriptive_maps', {})

function! s:describe(map_command, map_args, lhs, rhs, description)
    echom a:map_command . a:map_args . a:lhs . a:rhs . a:description

    let g:descriptive_maps[a:map_command] = get(g:descriptive_maps, 'a:map_command', {})
    let g:descriptive_maps[a:map_command][a:lhs] = {'rhs': a:rhs, 'description': a:description}
endfunction

function! s:show_description()
    echo g:descriptive_maps
endfunction

"" In your .vimrc: dmap(<map-command>, <args>, <lhs>, <rhs>, <documentation>)
command! -nargs=+ Describe call <SID>describe(<f-args>)

Describe a b c d e
Describe nmap woot <leader>h <SID>show_description()<CR> Show_cool_stuff\ hello

echo s:show_description()
