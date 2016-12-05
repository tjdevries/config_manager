" My nvim-qt specific configuration

if has('win32')
  Guifont Fira Mono Medium for Powerline:h12
  " Guifont Inconsolata for Powerline:h12
else
  Guifont Fira Mono Medium for Powerline:h10
endif

" Always use true colors in nvim-qt
set termguicolors
