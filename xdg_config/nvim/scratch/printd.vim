""
" Return a formatted string.
" printf syntax with variable names:
"   {var_name:printf_syntax}\
"   ==> {name:5s}
"   ==> {my_int:3.3d}
"   etc.
function! PrintD(format_string, dict) abort
  let new_result = a:format_string
  let old_result = ''

  " Make sure to not change the original dictionary
  let temp_dict = deepcopy(a:dict)

  " If  the result hasn't changed after a whole run through of the dictionary keys
  " we must be done
  while old_result != new_result
    " Increment the value
    let old_result = new_result

    " Check the replacement keys
    for key in keys(temp_dict)
      " If the "{key" isn't even in the string,
      " just remove it and continue
      if strridx(new_result, '{' . key) < 0
        call remove(temp_dict, key)
        continue
      endif

      " Subsitute the key with proper printf sequence
      let new_result = substitute(new_result,
            \ '{' . key . '\%[:\([^{}]*\)]}',
            \ '\=printf("%" . (len(submatch(1)) > 0 ? submatch(1) : "s"), temp_dict[key])',
            \ '')
    endfor
  endwhile

  return new_result
endfunction

let s:name = 'tj'
let s:greet = 'going'
let s:trunc = '2long string'
let s:name_length = 10

let g:format_string = 'hello {name:{name_length}s}: how is it {greet}? Truncated ==> {trunc:.5s}'
" If you want to pass a dictionary, you can.
echo PrintD(format_string, {'name': 'tj', 'greet': 'going', 'trunc': '2long string', 'name_length': 10})
" You could also pass a built-in dict. for example "l:", "g:", etc...
echo PrintD(g:format_string, s:)


" If you have scriptease, you can time running it 1000 times
" for i in range(1,9000)
"   let s:hello_long_string{i} = i
" endfor
" 1000Time call PrintD(g:format_string, s:)
