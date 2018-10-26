scriptencoding 'utf-8'

" Dictionary of type:
" mode_result: ['long_string', 'short_string', optional - 'highlight type']
let g:currentmode = {
    \ 'n'  : ['Normal', 'N', 'NormalMode'],
    \ 'no' : ['N·OpPd', '?', 'OpPending' ],
    \ 'v'  : ['Visual', 'V', 'VisualMode'],
    \ 'V'  : ['V·Line', 'Vl', 'VisualLineMode'],
    \ '' : ['V·Blck', 'Vb' ],
    \ 's'  : ['Select', 'S' ],
    \ 'S'  : ['S·Line', 'Sl' ],
    \ '' : ['S·Block', 'Sb' ],
    \ 'i'  : ['Insert', 'I', 'InsertMode'],
    \ 'ic' : ['ICompl', 'Ic', 'ComplMode'],
    \ 'R'  : ['Rplace', 'R', 'ReplaceMode'],
    \ 'Rv' : ['VRplce', 'Rv' ],
    \ 'c'  : ['Cmmand', 'C', 'CommandMode'],
    \ 'cv' : ['Vim Ex', 'E' ],
    \ 'ce' : ['Ex (r)', 'E' ],
    \ 'r'  : ['Prompt', 'P' ],
    \ 'rm' : ['More  ', 'M' ],
    \ 'r?' : ['Cnfirm', 'Cn'],
    \ '!'  : ['Shell ', 'S'],
    \ 't'  : ['Term  ', 'T', 'TerminalMode'],
    \ }

let s:current_mode_color = ''
let s:left_sep = ' ❯❯ '
let s:right_sep = ' ❮❮ '
let s:long_name = v:false
let s:git_helper = 'gina'

let s:tags_enabled = v:false
let s:complex_tags_enabled = v:false

function! my_stl#get_mode_highlight() abort

endfunction

function! my_stl#get_mode() abort
    let l:m = mode(1)

    " if l:m == 'no'
    "   if &relativenumber
    "     setlocal norelativenumber
    "   endif
    " else
    "   if !&relativenumber
    "     setlocal relativenumber
    "   endif
    " endif

    " Can have a longer name, with more info, or just a one letter name
    let l:mode_index = s:long_name ? 0 : 1
    if has_key(g:currentmode, l:m)
      let l:mode = g:currentmode[l:m][l:mode_index]
    else
      let l:mode = '?'
    endif

    if len(l:mode) > 1
      let l:leading_space = ''
    else
      let l:leading_space = ' '
    endif

    return printf('%s [%s]%s%%*', my_stl#get_user_color(l:m), l:mode, l:leading_space)
endfunction

function! my_stl#add_left_separator() abort
  return s:left_sep
endfunction

function! my_stl#add_right_separator() abort
  return s:right_sep
endfunction

function! my_stl#get_user_color(mode) abort
  if !has_key(g:currentmode, a:mode)
    return ''
  endif

  if len(g:currentmode[a:mode]) > 2
    let l:color_code = g:currentmode[a:mode][2]

    if type(l:color_code) == type(1)
      return '%' . l:color_code . '*'
    else
      return '%#' . l:color_code . '#'
    endif
  else
    let l:color_code = 9
    return '%' . l:color_code . '*'
  endif
endfunction

function! my_stl#get_file_hightlight(buffer_number) abort
  if nvim_buf_get_option(a:buffer_number, 'filetype') == 'help'
    return 'HelpDoc'
  endif

  return ''
endfunction

function! my_stl#get_file_name(name_length, relative_depth) abort
  " Quit for terminals
  if exists('b:term_title')
    return expand('%')
  endif

  " Handle empty buffers
  if expand('%') ==? '[No Name]'
        \ || expand('%') ==? ''
    return '[No Name]'
  endif

  " Special name for lookitt buffers
  if &filetype ==? 'lookitt'
    let name = nvim_buf_get_name(0)
    return substitute(name[stridx(name, '[Putty'):], '\(.*\)@\(\w*\)\..*', '\1@\2', '')
  endif

  if &buftype == 'nofile'
    return bufname(0)
  endif

  if has_key(b:, '__tj_file_name') && type(b:__tj_file_name) == v:t_dict
    if &filetype == get(b:__tj_file_name, 'filetype', '')
          \ && getcwd() == get(b:__tj_file_name, 'cwd', '')
      return b:__tj_file_name.file_name
    endif
  endif

  let file_name = maktaba#path#Split(expand('%'))
  let my_pwd = maktaba#path#Split(substitute(getcwd(winnr(), tabpagenr()), "\n", '', 'g'))
  let result_name = ''

  let index = 0
  for index in range(len(file_name))
    if index >= len(my_pwd)
      break
    endif

    if file_name[index] !=# my_pwd[index]
      break
    endif
  endfor


  if len(my_pwd) - index < a:relative_depth
    for common_index in range(len(my_pwd) - index)
      let result_name .= '../'
    endfor

    " TODO: Try and prepend a './' when we don't have relative paths downward
    " if len(my_pwd) - index == 1
    "   let result_name .= './'
    " endif

    while index < len(file_name)
      let result_name .= file_name[index] . '/'
      let index += 1
    endwhile

    let result_name =  result_name[:-2]
  else
    let result_name = expand('%')
  endif

  let result_name = tj#standard_file_name(result_name)

  " Filetype specifics here
  if &filetype == 'help'
    let result_name = substitute(result_name, '^.*doc/', 'doc/', '')
  endif

  " a:name_length letters, then any word chacters followed by a slash
  " Replace the first string with that string and "/"
  " Do it for all of them
  let file_name = substitute(result_name, '\(' . repeat('[^/]', a:name_length) . '\)[^/]*/', '\1/', 'g')

  let b:__tj_file_name = {
        \ 'file_name': file_name,
        \ 'filetype': &filetype,
        \ 'cwd': getcwd(),
        \ }
  return file_name
endfunction

function! my_stl#get_git() abort
  " TODO: Make it so this doesn't have to be called int the %{} syntax
  " I want it to be called and be able to add highlighting to the item.
  " Could modify the return values and add the required highlighting.
  let stl = ''

  " Check for git information
  if std#cache#get(b:, '_stl_git_file', function('tj#is_git_file'))
    " {{{  Git status
    if s:git_helper ==# 'fugitive'  " {{{
      if exists('*fugitive#head') && (
                  \ exists('b:git_dir')
                  \ || len(fugitive#head(8)) > 0
                  \ )
          let stl .= "\ue0a0 "
          let stl .= fugitive#head(8)
      endif " }}}
    elseif s:git_helper ==# 'gita'  " {{{
      if !has('win32')
        let stl .= "\ue0a0 "
      endif
      let stl .= gita#statusline#format('%ln')[:5]
      let stl .= '/'

      let l:branch_name = gita#statusline#format('%lb')[:5]

      if l:branch_name ==? 'master'
        let stl .= l:branch_name
      else
        let stl .= l:branch_name
        " let stl .= '%#WarningMsg#' . l:branch_name . '%0*'
      endif
      " }}}
    elseif s:git_helper ==# 'gina'  " {{{
      let win_width = nvim_win_get_width(0)

      " TODO: Make wait time configurable
      " Wait awhile between checking values. No need to check it so often
      try
        if win_width > 120
          let stl .= std#cache#get(b:, '_stl_gina_fancy', funcref('gina#component#repo#preset', ['fancy']), 300)
        else
          let stl .= std#cache#get(b:, '_stl_gina_regular', funcref('gina#component#repo#branch'), 300)
        endif
      catch
        try
          call gina#component#repo#preset()
        catch
        endtry
      endtry
    " }}}
    endif  " }}}
    " {{{ Git diffs
    if exists('*GitGutterGetHunkSummary')
        let results = std#cache#get(b:, '_stl_hunk_summary', funcref('GitGutterGetHunkSummary'), 60)

        if results != [0, 0, 0]
          let diff_symbols = ['+', '~', '-']

          let diff_line = ''
          for i in range(3)
              if results[i] > 0
                  let diff_line .= l:diff_symbols[i] . string(results[i]) . ', '
              endif
          endfor

          let stl .= ' [' . diff_line[:-3] . ']'
        endif
    endif

    if len(stl) > 0
      let stl .= my_stl#add_left_separator()
    endif
  " }}}
  endif
  return stl
endfunction

function! my_stl#get_tag_name() abort
  if !s:tags_enabled
    return ''
  endif

  if !exists('w:_my_stl_tag_name')
    let w:_my_stl_tag_name = ''
  endif

  if g:_active_buffer == bufnr('%')
    if !s:complex_tags_enabled
      let w:_my_stl_tag_name = tagbar#currenttag('%s', '', 'f')
    else
      try
        let w:_tag_declaration = tagbar#currenttag('%s', '', 'p')
        let w:_tag_definition  = tagbar#currenttag('%s', '', 'f')
        let w:_tag_signature   = tagbar#currenttag('%s', '', 's')
      catch
        return ''
      endtry

      let w:_my_stl_tag_name = ''
      if winwidth('%') > len(w:_tag_declaration) * 8 && len(w:_tag_declaration) > 0
        let w:_my_stl_tag_name .=  w:_tag_declaration
      elseif winwidth('%') > len(w:_tag_definition) * 4 && len(w:_tag_definition) > 0
        let w:_my_stl_tag_name .= w:_tag_definition
      elseif winwidth('%') > len(w:_tag_signature) * 2 && len(w:_tag_signature) > 0
        let w:_my_stl_tag_name .= w:_tag_signature
      else
        let w:_my_stl_tag_name .= ''
      endif
    endif

    if len(w:_my_stl_tag_name) > 0
      let w:_my_stl_tag_name .= my_stl#add_right_separator()
    endif
  endif

  return w:_my_stl_tag_name
endfunction

function! my_stl#system_to_buf_var(variable, system_command) abort
  let b:{a:variable} = 'checking'

  let b:_stl_job_id_{a:variable} = jobstart(a:system_command, {
        \ 'on_stdout': {job_id, result, event ->
          \ execute('let b:' . a:variable . ' = result') },
        \ })

  return b:stl_job_id
endfunction

" Wait one minute
" let g:circle_wait_time = 60
" call my_stl#system_to_buf_var('circle_status', [
"       \ 'while [ 1 ]',
"       \ 'do',
"         \ 'circle status > /dev/null',
"         \ 'if [ $? -eq 0 ]; then; echo "pass"; else; echo "fail"; fi',
"         \ 'sleep ' . string(g:circle_wait_time),
"       \ 'done',
"       \ ])


function! my_stl#get_warehouse_dlg() abort
  let file_name = expand('%:p')
  if match(file_name, 'Warehouse') < 0
    return ''
  endif

  let parsed_split = split(matchstr(file_name, '\d*\\Warehouse'), '\\')
  if len(parsed_split) > 0
    return '[' . parsed_split[0] . '] '
  end

  return ''
endfunction

" {{{ Old functions
function! my_stl#change_user_color(num) abort
  if (mode() =~# '\v(n|no)')
    " exe 'hi StatusLine ctermfg=008'
    " exe 'highlight User' . string(a:num) . ' guibg=blue'
    let l:colors = g:colorpal_airline['normal']
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    " exe 'hi! StatusLine ctermfg=005'
  elseif (mode() ==# 'i')
    " exe 'hi! StatusLine ctermfg=004'
    " exe 'highlight User' . string(a:num) . ' guibg=red'
    " exe 'CPHL User' . string(a:num) . ' MyInsert MyInsert MyInsert'
    let l:colors = g:colorpal_airline['insert']
  else
    " exe 'hi! StatusLine ctermfg=006'
  endif


  " return ''
  return '%' . string(a:num) . '*'
endfunction

function! my_stl#set_up_colors() abort
  " exe 'CPHL User' . string(a:num) . ' ' . l:colors[a:num - 1][0] . ' ' . l:colors[a:num - 1][1]
endfunction
" }}}
