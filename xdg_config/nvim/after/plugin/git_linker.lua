local ok, gitlinker = pcall(require, "gitlinker")
if not ok then
  return
end

-- <leader>gy yanks current line from github.
return gitlinker.setup()
