if !exists('g:tabular_loaded')
  finish
endif

AddTabularPattern! nvar /nvarchar(\w*)/l1r0
AddTabularPattern! f_comma /^[^,]*\zs,/
AddTabularPattern! f_colon /^[^:]*\zs:/
