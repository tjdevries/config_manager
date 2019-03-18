
let test = {}

function! test.sort(a, b) dict abort
  echo self
  return a:a > a:b
endfunction

echo test.sort(5, 3)
echo sort([1, 4, 3, 5, 10], funcref('test.sort', []), test)
