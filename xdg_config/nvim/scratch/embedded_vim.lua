vim.cmd [[
  echo "hello world"
]]

local ffi = require "ffi"

ffi.cdef [[
  int main() {
    char *x = "hello";
    int x = 5;
    bool y = true;
  }
]]

local x = vim.cmd [[
function hello#world(arg) abort
  echo "hi"
  echo a:arg
endfunction
]]

print(x)
