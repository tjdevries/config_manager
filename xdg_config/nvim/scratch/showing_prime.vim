
function! MapFun(key, val)
  return a:val + 1
endfunction

echo map([1, 2, 3], funcref('MapFun'))
echo map([1, 2, 3], { key, val -> val + 1 })
