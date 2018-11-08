" syntax region Debug start=":" end=":"

syntax clear

" Links
syntax match RSTWords "\:\a\+\:"
syntax match RSTLink "`\a*`"

highlight link RSTWords Keyword
highlight link RSTLink Identifier

" Directives
syntax match RSTDirective "^\.\. _\@!.*$" 
syntax match RSTLinkTitle "^\.\. _.*$" 

highlight link RSTDirective Constant
highlight link RSTLinkTitle Comment

" From riv.vim
syn match rstDefinitionList `\v^(\s*)\h[^:]*\ze%(\s:\s.*)*\n\1\s+\S`
syn match rstBulletList `\v^\s*[-*+]\ze\s+`
syn match rstEnumeratedList `\v\c^\s*%(\d+|[#a-z]|[imlcxvd]+)[.)]\ze\s+`
syn match rstEnumeratedList `\v\c^\s*\(%(\d+|[#a-z]|[imlcxvd]+)\)\ze\s+`
syn match rstOptionList `\v^\s*%(-\w%( \w+)=|--[[:alnum:]_-]+%(\=\w+)=|/\u)%(, %(-\w%( \w+)=|--[[:alnum:]_.-]+%(\=\w+)=|/\u))*%(  |\t)\ze\s*\S`
syn match rstFieldList `\v^\s*:[^:[:space:]][^:]+:\_s`
syn match rstRoles `\v\s:\zs\w+\ze:\``
syn match rstBibliographicField `\v^\s*:(Author|Authors|Organization|Contact|Address|Version|Status|Date|Copyright|Dedication|Abstract):\_s`

syn match rstBlockQuoteAttr  `\v%(\_^\s*\n)@<=\s+---=\s.*`

syn match   rstCommentTitle '\v(^\s+|(^\.\.\s+)@<=):=\u\w*(\s+\u\w*)*:' contained 
syn cluster rstCommentGroup contains=rstCommentTitle,rstTodo

hi def link rstTodoItem     Include
hi def link rstTodoPrior    Include
hi def link rstTodoTmBgn    Number
hi def link rstTodoTmEnd    Number
hi def link rstDoneRegion   Comment

hi link rstStandaloneHyperlink          Underlined
hi link rstFootnoteReference            Underlined
hi link rstCitationReference            Underlined
hi link rstHyperLinkReference           Underlined
hi link rstInlineInternalTargets        Keyword
hi link rstPhaseHyperLinkReference      Underlined

hi def link rstBulletList                   Function
hi def link rstEnumeratedList               Function
hi def link rstDefinitionList               Statement
hi def link rstFieldList                    Function
hi def link rstBibliographicField           Constant
hi def link rstOptionList                   Statement
hi def link rstRoles                        Operator

hi def link rstBlockQuoteAttr               Exception
hi def link rstCommentTitle                 SpecialComment
