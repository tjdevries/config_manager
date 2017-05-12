let s:ahk_script_dir = fnameescape(fnamemodify($MYVIMRC, ':h')) . '\..\ahk'

" Load main.ahk
function! ahk#load_main() abort
  return jobstart('C:\AutoHotkey\AutoHotkey.exe ' . s:ahk_script_dir . '\main.ahk')
endfunction
