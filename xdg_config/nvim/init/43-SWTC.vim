" Vim global plugin for Star Wars crawls
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

"######################################################################
"##                                                                  ##
"##   To use:                                                        ##
"##                                                                  ##
"##        :SWTC  <filename>                                         ##
"##                                                                  ##
"##   See file 'intro.swtc' for the crawl-specification syntax       ##
"##                                                                  ##
"######################################################################


" If already loaded, we're done...
if exists("loaded_SWcrawl")
    finish
endif
let loaded_SWcrawl = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim

" Set up the actual colon command...
command! -nargs=1 -complete=file  SWTC  call SWcrawl(<f-args>)


" Implementation....

let s:CRAWL_SPEED      = 1   "(lines per second)
let s:STAR_DENSITY     = 50  "(pixels per star, i.e. 1 star per STAR_DENSITY pixels)
let s:STARFIELD_HEIGHT = 2   "(screens deep)

let s:LOGO_LINE1         = '^\s*\[\zs.*\ze\]\s*$'
let s:LOGO_LINE2         = '^\s*\[\[\zs.*\ze\]\]\s*$'
let s:LOGO_LINE3         = '^\s*\[\[\[\zs.*\ze\]\]\]\s*$'
let s:LOGO_LINE4         = '^\s*\[\[\[\[\zs.*\ze\]\]\]\]\s*$'
let s:CENTRED_CRAWL_LINE = '^\s*[>]\s*\zs.\{-}\ze\s*[<]\s*$'
let s:CRAWL_LINE         = '^\s*[|]\s*\zs.\{-}\ze\s*[|]\s*$'
let s:PREFACE_LINE       = '^\s*\zs.\{-}\ze\s*$'

highlight SWC_PREFACE    ctermfg=cyan
highlight SWC_FADE_LIGHT ctermfg=cyan
highlight SWC_FADE_DARK  ctermfg=blue
highlight SWC_LOGO       ctermfg=yellow cterm=bold
highlight SWC_CRAWL      ctermfg=yellow
highlight SWC_STAR       ctermfg=white
highlight SWC_BLACK      ctermfg=black  ctermbg=black

let s:PREFACE_POS = { 'x': 10, 'y': 5 }

function! SWcrawl (textsource)
    " Load preface, logo, and text to be crawled...
    let preface   = []
    let logo1     = []
    let logo2     = []
    let logo3     = []
    let logo4     = []
    let crawl     = []
    let centred   = []
    let max_crawl_width = 0
    for nextline in readfile(a:textsource)
        " Ignore blank lines...
        if nextline =~ '^\s*$'
            continue

        " Lines in [...] are logo components...
        elseif nextline =~ s:LOGO_LINE4
            let logo4 += [ matchstr(nextline, s:LOGO_LINE4) ]
        elseif nextline =~ s:LOGO_LINE3
            let logo3 += [ matchstr(nextline, s:LOGO_LINE3) ]
        elseif nextline =~ s:LOGO_LINE2
            let logo2 += [ matchstr(nextline, s:LOGO_LINE2) ]
        elseif nextline =~ s:LOGO_LINE1
            let logo1 += [ matchstr(nextline, s:LOGO_LINE1) ]

        " Lines in |...| are crawl components...
        elseif nextline =~ s:CRAWL_LINE
            let next_crawl = matchstr(nextline, s:CRAWL_LINE)
            if strlen(next_crawl) > max_crawl_width
                let max_crawl_width = strlen(substitute(next_crawl,'\s\+',' ','g'))
            endif
            let crawl   += [ next_crawl ]
            let centred += [ 0 ]

        " Lines in >...< are centred crawl components...
        elseif nextline =~ s:CENTRED_CRAWL_LINE
            let next_crawl = matchstr(nextline, s:CENTRED_CRAWL_LINE)
            if strlen(next_crawl) > max_crawl_width
                let max_crawl_width = strlen(substitute(next_crawl,'\s\+',' ','g'))
            endif
            let crawl   += [ next_crawl ]
            let centred += [ 1 ]

        " Anything else is preface...
        else
            let preface += [ substitute(matchstr(nextline, s:PREFACE_LINE), "^\s*", repeat(" ",s:PREFACE_POS.x), '') ]

        endif
    endfor

    " Ensure all logos available...
    let logo1 = len(logo1) ? logo1 : ["YOUR", "LOGO", "HERE"]
    let logo2 = len(logo2) ? logo2 : copy(logo1)
    let logo3 = len(logo3) ? logo3 : copy(logo2)
    let logo4 = len(logo4) ? logo4 : copy(logo3)

    " Save current buffer for final transition effect...
    let original_buffer = getline(1,'$')

    " Switch to a new buffer...
    let prev_matches = getmatches()
    enew!
    let b:WIN = { 'x' : winwidth(0), 'y' : winheight(0) }
    call setline(1, repeat([""], b:WIN.y + 1))

    " And hide annoyances...
    set lcs=
    let old_rulerformat = &rulerformat
    let &rulerformat="%#SWC_BLACK#%l" 
    echo ""

    " Generate starfield...
    let stars = SWC_gen_stars()

    " Clear screen...
    call setline(1, repeat([""], s:STARFIELD_HEIGHT * b:WIN.y) + original_buffer)
    redraw
    sleep 2

    " Start with preface...
    call matchadd('SWC_PREFACE', '.', 100)
    call setline(s:PREFACE_POS.y, preface)
    echo ""
    redraw
    sleep 5

    " Clean up...
    call clearmatches()
    call setline(s:PREFACE_POS.y, repeat([""], len(preface)))
    echo ""
    redraw
    sleep 1

    " Then show logo receding at centre of screen...
    call clearmatches()
    call matchadd('SWC_BLACK', '*',             102)
    call matchadd('SWC_STAR',  '\s\zs[.]\ze\s', 101)
    call matchadd('SWC_LOGO', '.',              100)
    call SWC_draw_logo(logo1)
    call SWC_paint_stars(stars)
    echo ""
    redraw
    sleep 3

    " Push it away...
    call setline(1, repeat([""], b:WIN.y))
    call SWC_draw_logo(logo2)
    call SWC_paint_stars(stars)
    echo ""
    redraw
    sleep 500m

    call setline(1, repeat([""], b:WIN.y))
    call SWC_draw_logo(logo3)
    call SWC_paint_stars(stars)
    echo ""
    redraw
    sleep 500m

    call setline(1, repeat([""], b:WIN.y))
    call SWC_draw_logo(logo4)
    call SWC_paint_stars(stars)
    echo ""
    redraw
    sleep 500m


    " Clean up...
    call clearmatches()
    call matchadd('SWC_STAR',  '\s\zs[.]\ze\s', 101)
    call setline(1, repeat([""], b:WIN.y))
    call SWC_paint_stars(stars)
    echo ""
    redraw
    sleep 2

    " Run crawl...
    call clearmatches()
    call matchadd('SWC_CRAWL', '.', 100)
    call matchadd('SWC_STAR',  '\s\zs[.]\ze\s', 101)
    for offset_from_bottom in range(1, len(crawl) + b:WIN.y)
        let crawl_line = offset_from_bottom < b:WIN.y ? 0 : offset_from_bottom - b:WIN.y + 1 
        for screen_line in range(1, b:WIN.y)
            if screen_line >= b:WIN.y - offset_from_bottom && crawl_line < len(crawl)
                let padded_line = SWC_pad(crawl[crawl_line], screen_line, centred[crawl_line], max_crawl_width)
                call setline(screen_line, padded_line)
                let crawl_line += 1
            else 
                call setline(screen_line, "")
            endif
        endfor
        call SWC_paint_stars(stars)
        echo ""
        redraw
        exec 'sleep ' . s:trunc(1000/s:CRAWL_SPEED) . 'm'
        if getchar(0) || offset_from_bottom > len(crawl) && padded_line !~ '\S'
            break
        endif
    endfor

    " Pan starfield down...
    call matchadd('SWC_FADE_DARK', '[^.]', 200)
    sleep 200m
    for offset_from_top in range(1, s:STARFIELD_HEIGHT * b:WIN.y)
        1delete
        redraw
        exec 'sleep ' . (200 - 2 * offset_from_top) . 'm'
    endfor
    sleep 200m


    " Switch back to previous buffer and restore normal highlighting...
    edit! #
    call setmatches(prev_matches)
    let &rulerformat = old_rulerformat
    redraw

endfunction

function s:trunc (n)
    return str2nr(string( a:n ))
endfunction

function! SWC_draw_logo (logo)
    let logo = copy(a:logo)

    " Find centre for logo...
    let logo_width = 0
    for line in logo
        if strlen(line) > logo_width
            let logo_width = strlen(line)
        endif
    endfor
    let logo_pos_x = (b:WIN.x - logo_width) / 2
    let logo_pos_y = (b:WIN.y - len(logo)) / 2

    " Move logo to centre...
    call map(logo, "repeat(' ', logo_pos_x) . v:val")

    " Draw logo
    call setline(logo_pos_y, logo)

endfunction

function! SWC_pad (text, y_pos, centred, max_text_width)

    " Does this need padding???
    let words = split(a:text, '\s\+')
    if len(words) < 1
        return a:text
    endif

    " How many unpadded characters are there???
    let unpadded_width = 0
    for word in words
        let unpadded_width += strlen(word)
    endfor

    " How much padding is needed???
    let rel_y = (2.0 * a:y_pos / b:WIN.y) - 1.0
    let stretched_width = s:trunc( a:max_text_width + rel_y * (b:WIN.x - a:max_text_width) )
    let required_padding = max([ 0, stretched_width - unpadded_width ])
    let indent = (b:WIN.x - stretched_width) / 2
    let gap_count = len(words) - 1

    " Is this a last line???
    let tight = a:centred || strlen(a:text) < 0.9 * a:max_text_width

    " Insert padding...
    if a:y_pos >= b:WIN.y/2
        let min_padding_needed_for = gap_count
        if tight
            let min_pad_per_gap = max([ 1, s:trunc(rel_y * 6.0) ])
        else
            let min_pad_per_gap = max([ 1, required_padding / gap_count ])
            let leftover_padding = required_padding - gap_count * min_pad_per_gap
            let min_padding_needed_for = min([ gap_count, gap_count - leftover_padding ])
        endif
        let padded_text = join(words[0 : min_padding_needed_for], repeat(" ", min_pad_per_gap))
        \               . repeat(" ", min_pad_per_gap+1)
        \               . join(words[min_padding_needed_for+1 : -1], repeat(" ", min_pad_per_gap+1))
        let padded_text = substitute(padded_text, '\s*$', '', '')

    " Or remove chars (in the distance)...
    elseif a:text =~ '\S'
"        let delta = s:trunc( 8.0 * (b:WIN.y/2 - a:y_pos) )
"        let greeked_len = max([ 0, strlen(substitute(a:text, '^\s*\|\s*$', '', 'g')) - delta ])
        let greeked_len = tight ? stretched_width * (unpadded_width + gap_count) / a:max_text_width : stretched_width
        let padded_text = repeat('~', greeked_len)

    " Or ignore it...
    else
        let padded_text = ""

    endif

    " Indent to centre...
    let padded_text = substitute(padded_text, '\s*$', '', '')
    let max_ever_padding = b:WIN.x - a:max_text_width
    let indent = a:centred ? (b:WIN.x - strlen(padded_text))/2
    \                      : indent
    return repeat(" ", indent) . padded_text
endfunction

function! SWC_gen_stars ()
    let star_count = b:WIN.x * s:STARFIELD_HEIGHT * b:WIN.y / s:STAR_DENSITY
    let stars = []
    for n in range(star_count)
        let x = RandomNumber(b:WIN.x) + 1
        let y = RandomNumber(s:STARFIELD_HEIGHT * b:WIN.y) + 1
        let stars += [{'y':y,'x':x}]
    endfor
    return stars
endfunction

function! SWC_paint_stars (stars)
    let max_x = b:WIN.x
    for star in a:stars
        let line = strpart(getline(star.y) . repeat(" ", max_x), 0, max_x)
        let line = substitute(line, '\s\zs\%'.(star.x-1).'c\s\ze\s', '.', '')
        call setline(star.y, line)
    endfor
endfunction

" Restore previous external compatibility options
let &cpo = s:save_cpo
