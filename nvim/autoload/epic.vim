let g:_epic_codesearch_version = 10
let g:_epic_cde_environment = 'CDETCP'
let g:_epic_emcsummary_version = 'TRACK'

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

" TODO: Add the ability to do an emc2 edit action, like:
" emc2://TRACK/ZQN/4162933?action=EDIT
let s:category_mapper = {
      \ 'QAN': 'ZQN',
      \ 'XDS': 'XDS',
      \ 'DLG': 'DLG',
      \ }
function! s:populate_emcsummary_url(version, category, number) abort
  return printf("http://emc2summary/GetSummaryReport.ashx/%s/%s/%s",
        \ a:version, s:category_mapper[a:category], a:number)
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

  let url = s:populate_codesearch_url(g:_epic_codesearch_version, parts[0], parts[1])

  return s:open_url(url, v:true)
endfunction


let s:goto_none = 0
let s:goto_record = 1
let s:goto_item = 2
let s:goto_summary = 3

" TODO: Use a dictionary to map to the correct type
let s:map_gotos = {
      \ s:goto_record: 'R \(\S\S\S\) \([0-9]*\)',
      \ s:goto_item: 'I \(\S\S\S\) \([0-9]*\)',
      \ s:goto_summary: '\(QAN\|XDS\|DLG\)\s*: \([0-9]*\)',
      \ }

let s:goto_default = s:goto_record

""
" Goto a snapper window in the CDE environment
" Or
" Goto a putty window and put in clipboard the macro
" Or
" Goto an emc2summary
" TODO: Add other environments
" TODO: Add more features from http://wiki/main/Orders/Testing_Utilities/Snapper/Snapper_URL_construction
function! epic#smart_goto()
  if has('unix')
    return
  endif

  " yank work and place in `e` (for epic!) register
  let old_options = getreg('e')
  normal m`"eyi```

  " Get the correct instruction
  let instruction = (old_options == getreg('e')) ?
        \ getline('.')
        \ : getreg('e')

  let goto_type = s:goto_none

  " Get the correct goto type
  for key in keys(s:map_gotos)
    let matched_list = matchlist(instruction, s:map_gotos[key])

    if len(matched_list) > 0
      let goto_type = key
      break
    endif
  endfor

  if goto_type == s:goto_none
    return 'Not a valid goto type: ' . string(instruction)
  endif

  " Check if it is a summary message
  if goto_type == s:goto_summary
    let category = matched_list[1]
    let number = matched_list[2]

    return s:open_url(s:populate_emcsummary_url(g:_epic_emcsummary_version, category, number), v:true)
  endif

  " Records and items have very similar ideas
  if (goto_type == s:goto_record || goto_type == s:goto_item)
    let ini = matched_list[1]
    let id = matched_list[2]

    if len(ini) != 3
      return 'Incorrect length INI: ' . ini
    endif

    if goto_type == s:goto_record
      return s:open_url(s:populate_snapper_url(g:_epic_cde_environment, ini, id), v:false)
    elseif goto_type == s:goto_item
      return s:open_putty(printf(";i %s %s\n", ini, id))
    endif
  endif

  return 'Something weird happened...'
endfunction


function! epic#get_linux_name()
  let file_name = expand('%')
  let file_name = substitute(file_name, '\\', '/', 'g')
  let file_name = substitute(file_name, '//', '/', 'g')
  let file_name = substitute(file_name, 'epic-nfs', 'net_home', '')
  call setreg('+', file_name)
  return file_name
endfunction

function! epic#test() abort
  vnew
  let g:test_id = termopen(['zsh'], {'on_stdout': {id, data, event-> nvim_set_var('output', data)}})
endfunction

function! epic#send_stuff() abort
  call jobsend(test_id, ";h e3p 155\r\n")
endfunction

let s:meeting_location = g:vimwiki_path . '/meetings/'

""
" Filter to the meetings who match a certain string
function! epic#filter_meetings(str) abort
  return filter(
        \ filter(
          \ map(
            \ glob(s:meeting_location . '*', v:true, v:true),
            \ {key, value -> fnamemodify(value, ":t")}
            \ ),
          \ {key, value -> matchstr(value, '\c.*' . a:str)}
          \ ),
        \ {key, value -> value != ''}
        \ )
endfunction

function! epic#next_one_on_one() abort
  return epic#filter_meetings('\d\d\d\d-\d\d-\d\d 1-1')[-1]
endfunction

function! epic#open_next_one_on_one() abort
  call execute(':edit ' . s:meeting_location . '/' . epic#next_one_on_one())

  return epic#next_one_on_one()
endfunction

function! epic#write_timelog_info(dict, o_list)
  call writefile(
        \ epic#add_timelog_info(a:dict, a:o_list),
        \ g:epic#log_location,
        \ "a")
endfunction

function! epic#add_timelog_info(dict, o_list) abort
  let extended_info = []

  let line_string = "\t- %-8s: %s"
  let extended_info = ['filename', 'description', 'QAN', 'XDS', 'DLG']

  call filter(
        \ map(extended_info,
          \ {index, key -> has_key(a:dict, key) && a:dict[key] != v:null ? printf(line_string, key, a:dict[key]) : '' }),
        \ {index, key -> key != ''})

  return a:o_list + extended_info
endfunction

function! epic#get_id(name) abort
  let lnum = search(a:name . ': \d*', 'n')

  if lnum == 0
    return v:null
  endif

  return matchlist(getline(lnum), ': \(\d*\)')[1]
endfunction

" TODO: Keep track of DLG, QAN, etc.
let s:default_epic_job = {
      \ 'id': -1,
      \ 'start': v:null,
      \ 'description': '',
      \ 'filename': '',
      \ 'QAN': '',
      \ 'DLG': '',
      \ 'XDS': '',
      \ }

let g:_epic_last_job = get(g:, '_epic_last_job', copy(s:default_epic_job))
let g:_epic_time_string = '%Y-%m-%d %H:%M'
let g:epic#log_location = g:vimwiki_path . '/projects/timelog.wiki'

function! epic#start_task(...) abort
  if a:0 > 0
    let description = a:1
  else
    let description = input('Description of task: ')
  endif

  if description == ''
    return
  endif

  if a:0 > 1
    let current_job = a:2
  else
    let current_job = get(g:, '_epic_last_job', copy(s:default_epic_job))
  endif

  if current_job.id && buffer_exists(current_job.id)
    call epic#finish_task(current_job)
  endif

  let current_job.id = nvim_buf_get_number(0)
  let current_job.start = localtime()
  let current_job.filename = fnamemodify(nvim_buf_get_name(0), ':t')
  let current_job.QAN = epic#get_id('QAN')
  let current_job.DLG = epic#get_id('DLG')
  let current_job.XDS = epic#get_id('XDS')
  let current_job.description = description

  let start_description = [
        \ 'STRT: '
        \ . strftime(g:_epic_time_string)
        \ . ' : '
        \ . current_job.description
        \ ]

  call nvim_buf_set_lines(
        \ current_job.id,
        \ 0,
        \ -1,
        \ v:false,
        \ nvim_buf_get_lines(current_job.id, 0, -1, v:false) + start_description
        \ )

  let timelog_description = epic#write_timelog_info(current_job, start_description)
endfunction

function! epic#finish_task(...) abort
  if a:0 > 0
    let current_job = a:1
  else
    let current_job = get(g:, '_epic_last_job', copy(s:default_epic_job))
  endif

  let finish_description = [
        \ 'DONE: ' 
        \ . strftime(g:_epic_time_string)
        \ . ' : Total minutes = '
        \ . (localtime() - current_job.start) / 60
        \ ]

  call nvim_buf_set_lines(
        \ current_job.id,
        \ 0,
        \ -1,
        \ v:false,
        \ nvim_buf_get_lines(current_job.id, 0, -1, v:false) + finish_description
        \ )

  let timelog_description = epic#write_timelog_info(current_job, finish_description)

  let g:_epic_last_job = copy(s:default_epic_job)
endfunction

" Epic Keymaps {{{
" Go to code search from a tag in ``
nnoremap <leader>gc :echo epic#goto_codesearch()<CR>

" Go to snapper
nnoremap <leader>ge :echo epic#smart_goto()<CR>

" Open next one-on-one
" <leader>w cause it goes to the wiki
" and 1 because I want to go to one-on-one :)
nnoremap <leader>w1 :echo epic#open_next_one_on_one()<CR>
" }}}
