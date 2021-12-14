-- Multiple filetypes embedded into lua

-- This is lua
-- I can easily make a comment! And then comment the next line
local x = 5

ffi.cdef [[
  int main(void) {
    // This is C
    // Why type comment starts?
    int result = 0; //  toggling comments in embedded filetypes??
    // when you can gco into the next line

    return 5;
  }
]]

local _ = vim.cmd [[
  " And this is vimscript!
  augroup HelloWorld
    au!
    " It even works in vimscript
    autocmd BufReadPost * :echo "This is vimscript. It really is"
    autocmd BufRead * :echo "You can tell cuase the highlight is cool"
  augroup END
]]

vim.api.nvim_define_augroup { group = "name", ... }
vim.api.nvim_define_autocmd { group = "name", ... }
