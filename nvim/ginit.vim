" My nvim-qt specific configuration

if has('win32')
  Guifont Fira Mono Medium for Powerline:h12
  " Guifont Inconsolata for Powerline:h12
else
  Guifont Fira Mono Medium for Powerline:h10
endif

" Always use true colors in nvim-qt
set termguicolors


let s:original_font_command = split(split(execute('Guifont'), "\n")[0], ':')
let s:original_font_name = s:original_font_command[0]
let s:original_font_size = s:original_font_command[1][1:]

let g:nvimqt_font = s:original_font_size

let s:font_index = 0
let g:nvimqt_potential_fonts = [
      \ s:original_font_name,
      \ 'Hack',
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
  let g:nvimqt_font_name = g:nvimqt_potential_fonts[s:font_index]

  call s:change_gui_font_size('', v:true)
endfunction

function! s:change_gui_font_size(action, global) abort
  if a:action ==# 'plus'
    let g:nvimqt_font = g:nvimqt_font + 1
  elseif a:action ==# 'minus'
    " Don't let the font go below 1
    let g:nvimqt_font = max([g:nvimqt_font - 1, 1])
  endif

  if a:global
    let s:current_font_name = g:nvimqt_font_name
  else
    let s:current_font_name = split(split(execute('Guifont'), "\n")[0], ':')[0]
  endif

  echo s:current_font_name . ':h' . string(g:nvimqt_font)

  try
    call execute('Guifont ' . s:current_font_name . ':h' . string(g:nvimqt_font))
  catch
    echo s:current_font_name . ':h' . string(g:nvimqt_font) . ' -> failed'
  endtry
endfunction

nnoremap <leader>+ :call <SID>change_gui_font_size('plus', v:false)<CR>
nnoremap <leader>- :call <SID>change_gui_font_size('minus', v:false)<CR>
nnoremap <leader><leader>f :call <SID>change_gui_font()<CR>

" Toggle maximizing the window
nnoremap <leader>wm :call GuiWindowMaximized(!g:GuiWindowMaximized)<CR>
" Toggle full screening the window
nnoremap <leader>wf :call GuiWindowFullScreen(!g:GuiWindowFullScreen)<CR>
