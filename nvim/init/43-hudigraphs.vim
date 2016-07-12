" Vim global plugin for heads-up digraph interactions...
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

"##############################################################################
"##                                                                          ##
"##  To use:                                                                 ##
"##                                                                          ##
"##    inoremap <expr>  <C-K>   HUDG_GetDigraph()                            ##
"##                                                                          ##
"##############################################################################


" If already loaded, we're done...
if exists("loaded_hudigraphs")
    finish
endif
let loaded_hudigraphs = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim


" Highlight group that emulates cursor appearance during digraph insertion...
highlight HUDG_Cursor_Emulation  ctermfg=blue ctermbg=white


" This elaboration intercepts the timeouts on regular getchar()...
function! s:active_getchar ()
    let char = 0
    while !char
        let char = getchar()
    endwhile
    return nr2char(char)
endfunction

" Retrieve the digraph list (should be called in a :silent)...
function! s:get_digraphs ()
    redir => digraphs
    digraphs
    redir END
    return substitute(digraphs,'\%d173', '-?','')   " Translate invisible soft-hyphen
endfunction

function! s:show_digraphs (digraphs, cursor_char, context)
    " Pad digraph table to fill screen
    let digraphs = copy(a:digraphs) + repeat(['~'], winheight(0))

    " Display first half of digraph table...
    echon "\n"
    echohl SpecialKey
    echon join(digraphs[0 : a:context.line-2], "\n") . "\n"

    " Display cursor line with emulated digraph marker...
    echohl Normal
    echon strpart(a:context.text, 0, a:context.col-1)
    echohl HUDG_Cursor_Emulation
    echon a:cursor_char
    echohl Normal
    echon strpart(a:context.text, a:context.col-1) . "\n"

    " Display remainder of digraph table...
    echohl SpecialKey
    echon join(digraphs[a:context.line-1 : winheight(0)-2], "\n") . "\n"
    echohl None
endfunction

let g:HUDG_filtering = 1

" Filter out digraphs that don't start or end with the specified character...
function! s:filter_digraphs (digraphs, char)
    if !g:HUDG_filtering
        return a:digraphs
    endif
    let digraphs = copy(a:digraphs)

    for line in range(len(digraphs))
        let filtered_line = []
        for digraph_spec in split(digraphs[line], '.\{9}\zs  ')
            let filtered_spec = substitute(digraph_spec, '\C^.. --> [^'.a:char.']\{2}\s*$', repeat(' ',9), '')
            let filtered_spec = substitute(filtered_spec, '\C^.. --> \S\zs['.a:char.']\ze\s*$', ' ', '')
            let filtered_spec = substitute(filtered_spec, '\C^.. --> \zs['.a:char.']\ze\S\s*$', ' ', '')
            let filtered_line += [filtered_spec]
        endfor
        let digraphs[line] = join(filtered_line, '  ')
    endfor

    return digraphs
endfunction

" Rearrange digraph table more usefully...
function! s:get_retabulated_digraphs ()
    " Get raw data...
    silent let digraphs_list = split(s:get_digraphs(), "\n")

    " Convert to table...
    let digraphs_table = []
    for line in range(len(digraphs_list))
        let table_line = []
        for digraph_spec in split(digraphs_list[line], '.\{9}\zs  ')
            let match_parts = matchlist(digraph_spec, '^\(..\) \(\S\{1,2}\)')
            if !len(match_parts)
                let match_parts = ['','??','?']
            endif
            let table_line += [printf("%2s",match_parts[2]) . ' --> ' . match_parts[1]]
        endfor
        let digraphs_table += [join(table_line, '  ')]
    endfor

    return digraphs_table
endfunction

" Emulate a more helpful ^K...
function! HUDG_GetDigraph ()
    " Locate cursor...
    let context = { 'line': winline(), 'col': wincol(), 'text': getline('.') }

    " Grab list of digraphs...
    let digraphs = s:get_retabulated_digraphs()

    " Simulate first char of two-character digraph code (with <C-K> or <ESC> to escape)...
    call s:show_digraphs(digraphs, '?', context)
    let char1 = s:active_getchar()

    " Simulate second char of two-character digraph code (with <C-K> or <ESC> to escape)...
    if (char1 == "\<C-K>" || char1 == "\<ESC>")
        let char2 = ""
    else
        call s:show_digraphs(s:filter_digraphs(digraphs, char1), char1, context)
        let char2 = s:active_getchar()
    endif

    " Return the digraph-constructing sequence...
    return "\<C-K>".char1.char2
endfunction


" Restore previous external compatibility options
let &cpo = s:save_cpo
