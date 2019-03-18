

" Make sure tabular is loaded
silent! call plug#load('tabular')
silent! call plug#load('Tabular')

if !exists('g:tabular_loaded')
  finish
endif

AddTabularPattern! nvar /nvarchar(\w*)/l1r0
