" My nvim-qt specific configuration

if has('win32')
  Guifont Fira Mono Medium for Powerline:h12
  " Guifont Inconsolata for Powerline:h12
else
  Guifont Fira Mono Medium for Powerline:h10
endif

" Always use true colors in nvim-qt
set termguicolors

let g:nvimqt_font = 14

let s:font_index = 0
let g:nvimqt_potential_fonts = [
      \ 'Fira Mono for Powerline',
      \ 'Anonymous Pro for Powerline',
      \ 'Cousine for Powerline',
      \ 'DejaVu Sans Mono for Powerline',
      \ 'Meslo LG M for Powerline',
      \ 'Ubuntu Mono derivative Powerline',
      \ 'Source Code Pro for Powerline',
      \ ]

let g:nvimqt_font_name = g:nvimqt_potential_fonts[s:font_index] . ':h'

function! s:change_gui_font() abort
  let s:font_index = float2nr(fmod(s:font_index + 1, len(g:nvimqt_potential_fonts)))
  let g:nvimqt_font_name = g:nvimqt_potential_fonts[s:font_index] . ':h'

  call s:change_gui_font_size('')
endfunction

function! s:change_gui_font_size(action) abort
  if a:action ==# 'plus'
    let g:nvimqt_font = g:nvimqt_font + 1
  elseif a:action ==# 'minus'
    let g:nvimqt_font = g:nvimqt_font - 1
  endif

  call execute('Guifont ' . g:nvimqt_font_name . string(g:nvimqt_font))
endfunction

nnoremap ,+ :call <SID>change_gui_font_size('plus')<CR>
nnoremap ,- :call <SID>change_gui_font_size('minus')<CR>
nnoremap ,,f :call <SID>change_gui_font()<CR>

