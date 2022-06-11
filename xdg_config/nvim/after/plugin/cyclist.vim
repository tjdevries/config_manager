set list

if !get(g:, 'loaded_cyclist', v:false)
  finish
endif

call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'trail': '·',
        \ 'extends': '<',
        \ 'precedes': '>',
        \ 'conceal': '┊',
        \ 'nbsp': '␣',
        \ })

call cyclist#add_listchar_option_set('busy', {
        \ 'eol': '↲',
        \ 'tab': '»·',
        \ 'space': '␣',
        \ 'trail': '-',
        \ 'extends': '☛',
        \ 'precedes': '☚',
        \ 'conceal': '┊',
        \ 'nbsp': '☠',
        \ })

if $USER == 'tj-wsl'
  call cyclist#add_listchar_option_set('wsl', {
          \ 'tab': '» ',
          \ })

  call cyclist#activate_listchars('wsl')
endif

" I can't figure out fonts and stuff on mac.
if has("macunix")
  silent! call cyclist#activate_listchars('limited')
endif

nmap <leader>cl <Plug>CyclistNext
