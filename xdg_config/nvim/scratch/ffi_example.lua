-- local x = 5

ffi.cdef [[
  int main(void) {
    // int result = 0;

    return 5;
  }
]]

local _ = vim.cmd [[
  augroup HelloWorld
    au!
    autocmd BufReadPost * :echo "This is vimscript. It really is"
    autocmd BufRead * :echo "You can tell cuase the highlight is cool"
  augroup END
]]

vim.api.nvim_define_augroup { group = "name", ... }
vim.api.nvim_define_autocmd { group = "name", ... }
