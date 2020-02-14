
exec 'luafile ' . expand('<sfile>:p:h') . '/lsp_config.lua'

" let settings = {
"           \   "pyls" : {
"           \     "enable" : v:true,
"           \     "trace" : { "server" : "verbose", },
"           \     "commandPath" : "",
"           \     "configurationSources" : [ "pycodestyle" ],
"           \     "plugins" : {
"           \       "jedi_completion" : { "enabled" : v:true, },
"           \       "jedi_hover" : { "enabled" : v:true, },
"           \       "jedi_references" : { "enabled" : v:true, },
"           \       "jedi_signature_help" : { "enabled" : v:true, },
"           \       "jedi_symbols" : {
"           \         "enabled" : v:true,
"           \         "all_scopes" : v:true,
"           \       },
"           \       "mccabe" : {
"           \         "enabled" : v:true,
"           \         "threshold" : 15,
"           \       },
"           \       "preload" : { "enabled" : v:true, },
"           \       "pycodestyle" : { "enabled" : v:true, },
"           \       "pydocstyle" : {
"           \         "enabled" : v:false,
"           \         "match" : "(?!test_).*\\.py",
"           \         "matchDir" : "[^\\.].*",
"           \       },
"           \       "pyflakes" : { "enabled" : v:true, },
"           \       "rope_completion" : { "enabled" : v:true, },
"           \       "yapf" : { "enabled" : v:true, },
"           \     }}}

" call nvim_lsp#setup("pyls", settings)
"
"

for file_type in ["lua", "python", "vim"]
  call execute(printf("autocmd Filetype %s nnoremap <buffer><silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>", file_type))
  call execute(printf("autocmd Filetype %s nnoremap <buffer><silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>", file_type))
  call execute(printf("autocmd Filetype %s nnoremap <buffer><silent> K     <cmd>lua vim.lsp.buf.hover()<CR>", file_type))
  call execute(printf("autocmd Filetype %s nnoremap <buffer><silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>", file_type))
  call execute(printf("autocmd Filetype %s nnoremap <buffer><silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>", file_type))
  call execute(printf("autocmd Filetype %s nnoremap <buffer><silent> gr    <cmd>lua vim.lsp.buf.references()<CR>", file_type))

  " Subject to change:
  call execute(printf("autocmd Filetype %s inoremap <buffer><silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<CR>", file_type))

endfor

" Helpful overrides for diagnostics

" [D]iagnostics [E]nable
nnoremap <silent> <space>de <cmd>lua require("custom.diagnostics").set_diagnostic_display(true)<CR>
" [D]iagnostics [D]isable
nnoremap <silent> <space>dd <cmd>lua require("custom.diagnostics").set_diagnostic_display(false)<CR>

" [D]iagnostics [C]ustom
nnoremap <silent> <space>dc <cmd>lua require("custom.diagnostics").use_custom(nil)<CR>



" This is the command I use for moving windows... need a new one
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
