    function! s:only_counts(motion) abort
      if v:count > 0
        let exec_string = printf('normal! %s', string(v:count) . a:motion)
        call execute(exec_string)
        echo exec_string
      else
        echo printf('Dude... you gotta stop using "%s"', a:motion)
      endif
    endfunction

    nnoremap j :<C-U>call <SID>only_counts('j')<CR>
    nnoremap k :<C-U>call <SID>only_counts('k')<CR>











