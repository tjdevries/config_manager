PROFILE_LOAD = false
if PROFILE_LOAD then
  require("jit.p").start("10,i1,s,m0,G", "/tmp/output_flame.log")
  vim.cmd [[au VimLeave * lua require'jit.p'.stop()]]
end
