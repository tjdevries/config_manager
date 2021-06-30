" Vim global plugin for better digraph interactions...
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

"##############################################################################
"##                                                                          ##
"##  To use:                                                                 ##
"##                                                                          ##
"##    inoremap <expr>  <C-K>   BDG_GetDigraph()                             ##
"##                                                                          ##
"##############################################################################
"##                                                                          ##
"##  Digraph naming scheme:                                                  ##
"##                                                                          ##
"##  1. Accented characters                                                  ##
"##                                                                          ##
"##      Always the letter itself, followed by                               ##
"##      the first character of the accent's name:                           ##
"##                                                                          ##
"##      A/a   -->  acute                  (e.g.  aa --> á    YA --> Ý  )    ##
"##      G/g   -->  grave                  (e.g.  ag --> à    og --> ò  )    ##
"##      C/c   -->  circumflex or cedilla  (e.g.  AC --> Â    cc --> ç  )    ##
"##      U/u   -->  umlaut                 (e.g.  au --> ä    UU --> Ü  )    ##
"##      T/t   -->  tilde                  (e.g.  at --> ã    nt --> ñ  )    ##
"##      S/s   -->  slash                  (e.g.  os --> ø    OS --> Ø  )    ##
"##      R/r   -->  ring                   (e.g.  AR --> Å              )    ##
"##                                                                          ##
"##                                                                          ##
"##  2. Unaccented characters                                                ##
"##                                                                          ##
"##      AE  -->  "[AE] diphthong"  -->  Æ                                   ##
"##      ae  -->  "[ae] diphthong"  -->  æ                                   ##
"##      TH  -->  "[TH]ORN          -->  Þ                                   ##
"##      th  -->  "[th]orn          -->  þ                                   ##
"##      EH  -->  "[E]T[H]          -->  Ð                                   ##
"##      eh  -->  "[e]t[h]          -->  ð                                   ##
"##      ss  -->  "long e[ss]"      -->  ß                                   ##
"##                                                                          ##
"##                                                                          ##
"## 3. Non-alphabetics                                                       ##
"##    (Usually the first letter(s) of each word, except where ambiguous,    ##
"##     in which case: the first and last letters are used instead.)         ##
"##                                                                          ##
"##      ce  -->  "[ce]nt"            -->  ¢                                 ##
"##      ci  -->  "[ci]rcumflex"      -->  ^                                 ##
"##      co  -->  "[co]pyright"       -->  ©                                 ##
"##      de  -->  "[de]gree"          -->  °                                 ##
"##      mu  -->  "[mu]"              -->  µ                                 ##
"##      no  -->  "[no]t"             -->  ¬                                 ##
"##      nu  -->  "[nu]mber"          -->  #                                 ##
"##      pa  -->  "[pa]ragraph"       -->  ¶                                 ##
"##      po  -->  "[po]und"           -->  £                                 ##
"##      re  -->  "[re]gistered"      -->  ®                                 ##
"##      se  -->  "[se]ction"         -->  §                                 ##
"##      sp  -->  "[sp]ace"           -->  <Space>                           ##
"##      ti  -->  "[ti]lde"           -->  ~                                 ##
"##      ye  -->  "[ye]n"             -->  ¥                                 ##
"##                                                                          ##
"##      as  -->  "[a]t [s]ign"       -->  @                                 ##
"##      bb  -->  "[b]roken [b]ar"    -->  ¦                                 ##
"##      bs  -->  "[b]ack [s]lash     -->  \                                 ##
"##      bt  -->  "[b]ack [t]ick"     -->  `                                 ##
"##      ds  -->  "[d]ivide [s]ign"   -->  ÷                                 ##
"##      ft  -->  "[f]orward [t]ick"  -->  ´                                 ##
"##      ms  -->  "[m]ultiply [s]ign" -->  ×                                 ##
"##      pm  -->  "[p]lus or [m]inus" -->  ±                                 ##
"##      vb  -->  "[v]ertical [b]ar"  -->  |                                 ##
"##                                                                          ##
"##      dr  -->  "[d]olla[r]"        -->  $                                 ##
"##      dt  -->  "[d]o[t]"           -->  ·                                 ##
"##                                                                          ##
"##                                                                          ##
"##  4. Brackets                                                             ##
"##     ('l/r' for left/right; 's/c/d' for square/curly/double-angle)        ##
"##                                                                          ##
"##      ls  -->  [    rs  -->  ]                                            ##
"##      lc  -->  {    rc  -->  }                                            ##
"##      ld  -->  «    rd  -->  »                                            ##
"##                                                                          ##
"##                                                                          ##
"##  3. Inverted punctuation                                                 ##
"##     (Always the character followed by 'i' for inverted)                  ##
"##                                                                          ##
"##      !i  -->  ¡                                                          ##
"##      ?i  -->  ¿                                                          ##
"##                                                                          ##
"##                                                                          ##
"##  3. Ordinals                                                             ##
"##     (Always the character followed by 'o')                               ##
"##                                                                          ##
"##      ao  -->  ª                                                          ##
"##      oo  -->  º                                                          ##
"##      1o  -->  ¹                                                          ##
"##      2o  -->  ²                                                          ##
"##      3o  -->  ³                                                          ##
"##                                                                          ##
"##                                                                          ##
"##  5. Some obvious pictographic alternatives                               ##
"##     (Generally, doubling the letter produces the common variant)         ##
"##                                                                          ##
"##      ++  -->  ±                                                          ##
"##      +-  -->  ±                                                          ##
"##      xx  -->  ×                                                          ##
"##                                                                          ##
"##      <<  -->  «                                                          ##
"##      >>  -->  »                                                          ##
"##                                                                          ##
"##      !!  -->  ¡                                                          ##
"##      ??  -->  ¿                                                          ##
"##                                                                          ##
"##      11  -->  ¹                                                          ##
"##      22  -->  ²                                                          ##
"##      33  -->  ³                                                          ##
"##                                                                          ##
"##      14  -->  ¼                                                          ##
"##      12  -->  ½                                                          ##
"##      34  -->  ¾                                                          ##
"##                                                                          ##
"##                                                                          ##
"##############################################################################


" If already loaded, we're done...
if exists("loaded_betterdigraphs")
    finish
endif
let loaded_betterdigraphs = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim

" Highlight group that emulates cursor appearance during digraph insertion...
highlight BDG_Cursor_Emulation  ctermfg=blue ctermbg=white

" Highlight group to display hints...
highlight default link  BDG_Digraph_Table  SpecialKey


" How many entries per line in the displayed table???
let s:ENTRIES_PER_LINE = 6
let s:INTER_ENTRY_GAP  = 2


" Precompute spacings...
let s:ENTRY_SPACING = repeat(" ", 9)
let s:GAP_SPACING   = repeat(" ", s:INTER_ENTRY_GAP)
let s:BLANK_LINE    = [repeat(s:ENTRY_SPACING . s:GAP_SPACING, s:ENTRIES_PER_LINE) ]

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
    let digraphs = copy(a:digraphs) + repeat([""], winheight(0))

    " Display first half of digraph table...
    echohl BDG_Digraph_Table
    echon join(digraphs[0 : a:context.line-2], "\n") . "\n"

    " Display cursor line with emulated digraph marker...
    echohl Normal
    echon strpart(a:context.text, 0, a:context.col-1)
    echohl BDG_Cursor_Emulation
    echon a:cursor_char
    echohl Normal
    echon strpart(a:context.text, a:context.col-1) . "\n"

    " Display remainder of digraph table...
    echohl BDG_Digraph_Table
    echon join(digraphs[a:context.line-1 : winheight(0)-2], "\n") . "\n"
    echohl None
endfunction

let g:BDG_filtering = 1

" Filter out digraphs that don't start or end with the specified character...
function! s:filter_digraphs (digraphs, char)
    if !g:BDG_filtering
        return a:digraphs
    endif
    let digraphs = copy(a:digraphs)

    for line in range(len(digraphs))
        let filtered_line = []
        for digraph_spec in split(digraphs[line], '.\{9}\zs  ')
            let filtered_spec = substitute(digraph_spec,  '\C^.. --> [^'.a:char.'].\s*$', repeat(' ',9), '')
            let filtered_spec = substitute(filtered_spec, '\C^.. --> \zs['.a:char.']\ze\S\s*$', ' ', '')
            let filtered_line += [filtered_spec]
        endfor
        let digraphs[line] = join(filtered_line, s:GAP_SPACING) . s:GAP_SPACING
    endfor

    return digraphs
endfunction

" Emulate a more helpful ^K...
function! BDG_GetDigraph ()
    " Locate cursor...
    let context = { 'line': winline(), 'col': wincol(), 'text': getline('.') }

    " Grab list of digraphs...
    let digraphs = s:digraph_table

    " Simulate first char of two-character digraph code (with <C-K> or <ESC> to escape)...
    call s:show_digraphs(digraphs, '?', context)
    let char1 = s:active_getchar()

    " Simulate second char of two-character digraph code (with <C-K> or <ESC> to escape)...
    if (char1 == "\<C-K>" || char1 == "\<ESC>")
        call feedkeys("\<BS>")
        return "\<C-K>\<ESC> "
    else
        call s:show_digraphs(s:filter_digraphs(digraphs, char1), char1, context)
        let char2 = s:active_getchar()
    endif

    " Return the digraph-constructing sequence...
    return get(g:BDG_digraphs, char1.char2, "")

endfunction


" Set up default set of characters if user hasn't specified...
if !exists('g:BDG_digraphs')
    let g:BDG_digraphs = {
    \
    \   'sp' : ' ',
    \   'nu' : '#',
    \   'dr' : '$',
    \   'as' : '@',
    \   'bs' : '\',
    \   'ci' : '^',
    \   'bt' : '`',
    \   'vb' : '|',
    \   'ti' : '~',
    \   'ft' : '´',
    \   "''" : '´',
    \
    \   'ls' : '[',       'rs' : ']',
    \   'lc' : '{',       'rc' : '}',
    \   'ld' : '«',       'rd' : '»',
    \   '<<' : '«',       '>>' : '»',
    \
    \   '!!' : '¡',       '??' : '¿',
    \   'i!' : '¡',       'i?' : '¿',
    \   '!i' : '¡',       '?i' : '¿',
    \
    \   'ce' : '¢',
    \   'po' : '£',
    \   'ye' : '¥',
    \
    \   'bb' : '¦',
    \   'se' : '§',
    \   'pa' : '¶',
    \   'co' : '©',
    \   're' : '®',
    \   'sh' : '­',
    \
    \   'mu' : 'µ',
    \   'no' : '¬',
    \   'dt' : '·',
    \   'do' : '·',
    \   '+-' : '±',
    \   'pm' : '±',
    \   'ms' : '×',
    \   'xx' : '×',
    \   'ds' : '÷',
    \   'di' : '÷',
    \   'de' : '°',
    \
    \   'ao' : 'ª',
    \   'oo' : 'º',
    \   '11' : '¹',
    \   '22' : '²',
    \   '33' : '³',
    \
    \   '14' : '¼',
    \   '12' : '½',
    \   '34' : '¾',
    \
    \   'AG' : 'À',   'EG' : 'È',   'IG' : 'Ì',   'OG' : 'Ò',   'UG' : 'Ù',
    \   'AA' : 'Á',   'EA' : 'É',   'IA' : 'Í',   'OA' : 'Ó',   'UA' : 'Ú',   'YA' : 'Ý',
    \   'AC' : 'Â',   'EC' : 'Ê',   'IC' : 'Î',   'OC' : 'Ô',   'UC' : 'Û',
    \   'AU' : 'Ä',   'EU' : 'Ë',   'IU' : 'Ï',   'OU' : 'Ö',   'UU' : 'Ü',
    \   'AT' : 'Ã',                               'OT' : 'Õ',
    \   'AR' : 'Å',
    \   'AE' : 'Æ',                               'OS' : 'Ø',
    \
    \   'ag' : 'à',   'eg' : 'è',   'ig' : 'ì',   'og' : 'ò',   'ug' : 'ù',
    \   'aa' : 'á',   'ea' : 'é',   'ia' : 'í',   'oa' : 'ó',   'ua' : 'ú',   'ya' : 'ý',
    \   'ac' : 'â',   'ec' : 'ê',   'ic' : 'î',   'oc' : 'ô',   'uc' : 'û',
    \   'au' : 'ä',   'eu' : 'ë',   'iu' : 'ï',   'ou' : 'ö',   'uu' : 'ü',   'yu' : 'ÿ',
    \   'at' : 'ã',                               'ot' : 'õ',
    \   'ar' : 'å',
    \   'ae' : 'æ',                               'os' : 'ø',
    \
    \   'CC' : 'Ç',
    \   'cc' : 'ç',
    \
    \   'NT' : 'Ñ',
    \   'NN' : 'Ñ',
    \   'nt' : 'ñ',
    \   'nn' : 'ñ',
    \
    \   'ss' : 'ß',
    \
    \   'TH' : 'Þ',
    \   'th' : 'þ',
    \   'DH' : 'Ð',
    \   'dh' : 'ð',
    \}
endif


function! s:by_value (v1, v2)
    return a:v1[1] < a:v2[1] ? -1
    \    : a:v1[1] > a:v2[1] ?  1
    \    :                      0
endfunction

" Remove any digraphs that were specified as unwanted...
if exists('g:BDG_remove')
    if type(g:BDG_remove) == type([])
        for char in g:BDG_remove
            call filter(g:BDG_digraphs, 'v:val != char')
        endfor
    else
        call filter(g:BDG_digraphs, 'v:val !~ g:BDG_remove')
    endif
endif

" Add any extra digraphs that were requested...
if exists('g:BDG_add')
    call extend(g:BDG_digraphs, g:BDG_add)
endif

" Create the display table components...
let s:digraph_table = []
let current_line    = []
for digraph in sort(items(g:BDG_digraphs), "\<SID>by_value")
    " Make soft hyphens printable...
    let digraph[1] = (digraph[1] == '­') ? '-?' : digraph[1]

    " Construct next entry in table...
    let current_line += [printf('%2s', digraph[1]) . ' --> ' . digraph[0]]

    " When next line of table is full, construct the line...
    if len(current_line) == s:ENTRIES_PER_LINE
        let s:digraph_table += [join(current_line, s:GAP_SPACING) . s:GAP_SPACING]
        let current_line = []
    endif
endfor
if len(current_line)
    let current_line += repeat([s:ENTRY_SPACING], s:ENTRIES_PER_LINE - len(current_line))
    let s:digraph_table += [join(current_line, s:GAP_SPACING) . s:GAP_SPACING]
endif
let s:digraph_table = s:BLANK_LINE + s:digraph_table + s:BLANK_LINE


" Restore previous external compatibility options
let &cpo = s:save_cpo
