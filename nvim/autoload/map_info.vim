function! s:get_abbrs() abort
  return split(execute('abbr'), "\n")
endfunction

function! s:get_maps() abort
  return split(execute('map'), "\n")
endfunction

function! s:get_dict(mapping, abbr) abort
  let map_split = split(a:mapping, ' ')
  " let map_split = matchlist(a:mapping, '^\(\S\)\s*\(\S*\)')
  let l:mode = a:abbr ? 'i' : map_split[0]
  let l:map = map_split[2]
  return maparg(l:map, l:mode, a:abbr, v:true)
endfunction

function! s:get_len_rhs(map_dict) abort
  return len(a:map_dict['rhs'])
endfunction

function! s:sum_items(abbr) abort
  let l:name = a:abbr ? 'abbreviations' : 'mappings'
  let l:all_maps = a:abbr ? s:get_abbrs() : s:get_maps()
  let l:this_total = 0
  for this_map in l:all_maps
    let l:this_total += s:get_len_rhs(s:get_dict(this_map, a:abbr))
  endfor

  let l:info_dict = {
        \ 'total number of ' . l:name: len(l:all_maps),
        \ 'total length of ' . l:name: l:this_total,
        \ 'average length of ' . l:name: l:this_total / len(l:all_maps),
        \ }

  return l:info_dict
endfunction

function! s:sum_all() abort
  let l:map_dict = s:sum_items(v:false)
  let l:abbr_dict = s:sum_items(v:true)

  let l:all_dict = extend(l:map_dict, l:abbr_dict)
  " let l:all_dict['total length'] = filter(l:all_dict, 'v:key =~ "total length"')
  let l:all_dict['total length'] = l:all_dict['total length of abbreviations'] + l:all_dict['total length of mappings']

  return l:all_dict
endfunction

" echo s:sum_items(v:false)
" echo s:sum_items(v:true)
" echo s:sum_all()
" let my_var = s:sum_all()

function! map_info#sum_items(abbr) abort
  return s:sum_items(a:abbr)
endfunction

function! map_info#sum_all() abort
  return s:sum_all()
endfunction


function! map_info#safe_map(mode, modifiers, lhs, rhs, description)
  if has('nvim')
    let map_string = printf('%s %s <describe> %s %s <description> %s',
          \ a:mode, a:modifiers, a:lhs, a:rhs, a:description)
  else
    let map_string = printf('%s %s %s %s',
          \ a:mode, a:modifiers, a:lhs, a:rhs)
  endif

  execute map_string
endfunction
