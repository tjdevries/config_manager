" Will return 10, not 5
function! TestTrying() abort
  try
    return 5
  catch
  finally
    return 10
  endtry

  return 3
endfunction

function! TestTrying2() abort
  try
    echo 'Will be echoed first'
    return 5
    echo 'Will not be echoed'
  catch
  finally
    echo 'Wow, this did something!'
  endtry
endfunction
