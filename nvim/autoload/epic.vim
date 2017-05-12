let s:codesearch_version = 10
let s:cde_environemnt = 'CDETCP'

let s:powershell_script_dir = fnameescape(fnamemodify($MYVIMRC, ':h')) . '\bin'

function! s:populate_codesearch_url(version, tag, routine) abort
  " Routine comes first
  " and then tag
  return printf("http://codesearch/.NET/SearchModules/Server/Routine.aspx?versionid=%s&name=%s#%s",
        \ a:version, a:routine, a:tag)
endfunction

function! s:populate_snapper_url(env, ini, id) abort
  return printf("snapper://%s.%s.%s",
        \ a:ini, a:id, a:env)
endfunction

" TODO: Figure out how to send text to putty
function! s:open_putty(text) abort
  let old_register = getreg('+')
  call setreg('+', a:text)
  call timer_start(2000, {-> jobstart('C:\AutoHotkey\AutoHotkey.exe '
        \ . s:powershell_script_dir
        \ . '\paste.ahk')})
  call timer_start(3000, {-> setreg('+', old_register)})
  return [jobstart(['powershell.exe', s:powershell_script_dir . '\send_to_putty.ps1']),
        \ 'putty',
        \ substitute(a:text, "\n", '', 'g')
        \ ]
endfunction

function! s:open_url(url, focus) abort
  let job_call = ['powershell.exe', s:powershell_script_dir . '\open_ie_tab.ps1', shellescape(a:url)]

  if a:focus
    let job_call = job_call + ['1']
  else
    let job_call = job_call + ['0']
  endif

  let job_id = jobstart(job_call)
  return [job_id] + job_call
endfunction

""
" Goto codesearch for the routine under cursor
" Currently only within "`tag^rou`"
" Opens tab in internet explorer and brings to focus!
function! epic#goto_codesearch() abort
  if has('unix')
    return
  endif

  let word = expand('<cWORD>')

  if matchstr(word, '`.*`') == ""
    return 'did not match'
  endif

  let parts = split(word[1:-2], '\^')

  if len(parts) != 2
    return string(parts)
  endif

  let url = s:populate_codesearch_url(s:codesearch_version, parts[0], parts[1])

  return s:open_url(url, v:true)
endfunction


let s:none = 0
let s:record = 1
let s:item = 2

let s:default = s:record

""
" Goto a snapper window in the CDE environment
" Or
" Goto a putty window and put in clipboard the macro
" TODO: Add other environments
" TODO: Add more features from http://wiki/main/Orders/Testing_Utilities/Snapper/Snapper_URL_construction
function! epic#goto_record_or_item()
  if has('unix')
    return
  endif

  " `Test This Thing`

  " yank work and place in `e` (for epic!) register
  normal m`"eyi```
  let options = split(getreg('e'), ' ')

  let goto_type = s:none

  if len(options) == 2
    " If it's only two things, set it to the default
    let goto_type = s:default

    let ini = options[0]
    let id = options[1]
  else
    if options[0] ==? 'R'
      let goto_type = s:record
    elseif options[0] ==? 'I'
      let goto_type = s:item
    endif

    let ini = options[1]
    let id = options[2]
  endif

  if goto_type == s:none
    return 'Not a valid item/record type: ' . string(options)
  endif

  if len(ini) != 3
    return 'Incorrect length INI: ' . ini
  endif

  if goto_type == s:record
    return s:open_url(s:populate_snapper_url(s:cde_environemnt, ini, id), v:false)
  elseif goto_type == s:item
    return s:open_putty(printf(";i %s %s\n", ini, id))
  endif
endfunction
