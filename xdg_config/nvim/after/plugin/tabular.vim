if !exists('g:tabular_loaded')
  finish
endif

AddTabularPattern! nvar /nvarchar(\w*)/l1r0
AddTabularPattern! f_comma /^[^,]*\zs,/
AddTabularPattern! f_colon /^[^:]*\zs:/
AddTabularPattern! f_equal /^[^=]*\zs=/
AddTabularPattern! f_quote /^[^"]*\zs"/l1r0
