" OnSyntaxChange.vim: Generate events when moving onto / off a syntax group.
"
" DEPENDENCIES:
"   - ingointegration.vim autoload script.
"
" Copyright: (C) 2012-2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.002	17-Jan-2013	Do not trigger modeline processing when
"				triggering.
"   1.00.001	25-May-2012	file creation
let s:save_cpo = &cpo
set cpo&vim

function! s:GetState( isInsertMode, pattern )
    let l:pos = getpos('.')
    if a:isInsertMode && col('.') == col('$') && col('.') > 1
	" When appending at the end of a line, the syntax must be determined
	" from the character before the cursor.
	let l:pos[2] -= 1
    endif
    return ingointegration#IsOnSyntaxItem(l:pos, a:pattern)
endfunction

let s:modeActionForEvent = {
\   'n': {
\       'BufEnter'    : 1,
\       'CursorMoved' : 1,
\       'InsertEnter' : 0,
\       'InsertLeave' : 1
\   },
\   'i': {
\       'CursorMovedI': 1,
\       'InsertEnter' : 1,
\       'InsertLeave' : 0
\   },
\   'a': {
\       'BufEnter'    : 1,
\       'CursorMoved' : 1,
\       'CursorMovedI': 1
\   }
\}
function! OnSyntaxChange#Trigger( isBufferLocal, isInsertMode, event )
    let l:patterns = (a:isBufferLocal ? b:OnSyntaxChange_Patterns : g:OnSyntaxChange_Patterns)
    let l:states = (a:isBufferLocal ? b:OnSyntaxChange_States : g:OnSyntaxChange_States)
    for l:mode in ['n', 'i', 'a']
	let l:what = get(s:modeActionForEvent[l:mode], a:event, -1)
	for l:name in keys(l:patterns[l:mode])
	    if l:what == -1
		continue
	    elseif l:what == 0
		let l:previousState = l:states[l:mode][l:name]
		let l:states[l:mode][l:name] = 0
		if ! l:previousState
		    continue
		endif
		let l:event = 'Syntax' . l:name . 'Leave' . toupper(l:mode)
	    else
		let l:previousState = l:states[l:mode][l:name]
		let l:currentState  = s:GetState(a:isInsertMode, l:patterns[l:mode][l:name])
		if l:previousState == l:currentState
		    continue
		else
		    let l:states[l:mode][l:name] = l:currentState
		endif
		let l:event = 'Syntax' . l:name . (l:currentState ? 'Enter' : 'Leave') . toupper(l:mode)
	    endif

	    if a:isBufferLocal && has_key(g:OnSyntaxChange_Patterns[l:mode], l:name)
		" Do not trigger the same event twice when the name is defined
		" both globally and buffer-local.
		continue
	    endif

	    if v:version == 703 && has('patch438') || v:version > 703
		execute 'silent doautocmd <nomodeline> User' l:event
	    else
		execute 'silent doautocmd              User' l:event
	    endif
"****D echomsg 'doautocmd User' l:event
	endfor
    endfor
endfunction

function! OnSyntaxChange#Install( name, syntaxItemPattern, isBufferLocal, mode )
"******************************************************************************
"* PURPOSE:
"   Set up User events for a:pat that fire when the cursor moves onto / away
"   from a syntax group matching a:syntaxItemPattern.
"* ASSUMPTIONS / PRECONDITIONS:
"   None.
"* EFFECTS / POSTCONDITIONS:
"   Events of the name "Syntax{name}Enter{MODE}" and "Syntax{name}Leave{MODE}"
"   are generated whenever the cursor moves onto / off the syntax group. {MODE}
"   is the upper-case a:mode.
"* INPUTS:
"   a:name  Description of the syntax element, to be used in the generated
"	    event, e.g. "Comment".
"   a:syntaxItemPattern Regular expression that specifies the syntax groups,
"			e.g. "^Comment$". For matching, the translated,
"			effective syntax name is used.
"   a:isBufferLocal Flag whether the event should be generated just for the
"		    current buffer, or globally for all buffers.
"   a:mode  The mode for which syntax group changes are detected. One of:
"	    "a": any mode; i.e. regardless of whether in normal and insert mode,
"	    events are fired when the syntax group is entered / left.
"	    "n": normal mode; when insert mode is entered, the corresponding
"	    "Leave" event is fired, even when the cursor stays inside the syntax
"	    group.
"	    "i": insert mode; when insert mode is left, the corresponding
"	    "Leave" event is fired, even when the cursor stays inside the syntax
"	    group.
"* RETURN VALUES:
"   None.
"******************************************************************************
    let l:isInsertMode = (mode() =~# '[iR]')

    if ! exists('g:OnSyntaxChange_Patterns')
	" The global variables must always be initialized, because buffer-local
	" triggers refer to them.
	let g:OnSyntaxChange_Patterns = {'n': {}, 'i': {}, 'a': {}}
	let g:OnSyntaxChange_States   = {'n': {}, 'i': {}, 'a': {}}
    endif

    if a:isBufferLocal
	if ! exists('b:OnSyntaxChange_Patterns')
	    let b:OnSyntaxChange_Patterns = {'n': {}, 'i': {}, 'a': {}}
	    let b:OnSyntaxChange_States   = {'n': {}, 'i': {}, 'a': {}}
	endif
	let b:OnSyntaxChange_Patterns[a:mode][a:name] = a:syntaxItemPattern
	let b:OnSyntaxChange_States[a:mode][a:name] = s:GetState(l:isInsertMode, a:syntaxItemPattern)
	let l:scope = '<buffer>'
    else
	let g:OnSyntaxChange_Patterns[a:mode][a:name] = a:syntaxItemPattern
	let g:OnSyntaxChange_States[a:mode][a:name] = s:GetState(l:isInsertMode, a:syntaxItemPattern)
	let l:scope = '*'
    endif


    augroup OnSyntaxChange
	if a:mode ==# 'n'
	    execute 'autocmd! CursorMoved ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 0, "CursorMoved")'
	    execute 'autocmd! BufEnter    ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 0, "BufEnter")'
	    execute 'autocmd! InsertEnter ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 1, "InsertEnter")'
	    execute 'autocmd! InsertLeave ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 0, "InsertLeave")'
	elseif a:mode ==# 'i'
	    execute 'autocmd! CursorMovedI' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 1, "CursorMovedI")'
	    execute 'autocmd! InsertEnter ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 1, "InsertEnter")'
	    execute 'autocmd! InsertLeave ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 0, "InsertLeave")'
	elseif a:mode ==# 'a'
	    execute 'autocmd! CursorMoved ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 0, "CursorMoved")'
	    execute 'autocmd! CursorMovedI' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 1, "CursorMovedI")'
	    execute 'autocmd! BufEnter    ' l:scope 'call OnSyntaxChange#Trigger(' a:isBufferLocal ', 0, "BufEnter")'
	else
	    throw 'ASSERT: Invalid mode: ' . string(a:mode)
	endif
    augroup END
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
