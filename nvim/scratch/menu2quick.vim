let s:debug = v:false

" Function to handle creating a menu entry for an actual mapping
function! s:handle_maps(menu, mode) abort
  if !has_key(a:menu, 'mappings')
    return
  endif

  if !has_key(a:menu.mappings, a:mode)
    return
  endif

  let rhs = a:menu.mappings[a:mode].rhs
  let rhs = substitute(rhs, "\r", '', 'g')
  let rhs = substitute(rhs, "\n", '', 'g')

  if s:debug
    echo 'MENU.RHS: ' string(rhs)
  endif

  call quickmenu#append(a:menu.name, rhs)
endfunction

" Recursive function to check for menus and handle menus
function! s:handle_menu(menu, mode) abort
  if has_key(a:menu, 'submenus')
    if s:debug
      echo 'MENU: ' . string(a:menu.name)
    endif

    call quickmenu#append('# ' . a:menu.name, '')
    call s:handle_maps(a:menu, a:mode)

    for submenu in a:menu.submenus
      call s:handle_menu(submenu, a:mode)
    endfor
  else
    call s:handle_maps(a:menu, a:mode)
  endif
endfunction

" Entry point for making menus
function! Menu2Quick(name, mode) abort
  let menu_list = menu_get(a:name, a:mode)

  call quickmenu#reset()
  call quickmenu#header(a:name)

  for menu in menu_list
    call s:handle_menu(menu, a:mode)
  endfor

  call quickmenu#toggle(0)
endfunction
