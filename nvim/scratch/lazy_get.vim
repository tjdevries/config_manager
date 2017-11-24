function F()
  echoerr 'should not get called'
endfunction
let getter_var = get({'foo': 1}, 'foo', F)
if type(getter_var) == v:t_func
    let getter_var = getter_var()
endif

" or...

" Assumes no arguments to the default...
function! LazyGet(dict, key, default) abort
    let getter = get(a:dict, a:key, a:default)

    if type(getter_var) == v:t_func
        return getter()
    else
        return getter
    endif
endfunction

