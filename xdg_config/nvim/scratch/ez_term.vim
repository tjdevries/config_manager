
function EasyTerm(command) abort
  let bufnr = nvim_create_buf(v:false, v:true)
  let win_id = nvim_open_win(bufnr, v:true, {
        \ 'relative': 'editor',
        \ 'width': float2nr(floor(&columns * 0.8)),
        \ 'height': float2nr(floor(&lines * 0.8)),
        \ 'col': 2,
        \ 'row': 2,
        \ 'style': 'minimal'
        \ })

  call termopen(a:command)
endfunction

function SimpleTerm(command) abort
  new 50
  call termopen(a:command)
endfunction
