" Mumps syntax file
" Language: MUMPS
" Original Author: Jim Self, jaself@ucdavis.edu (28 April 2001)
" Other Modifications:
"  2012-05-09 - *ARB- add spell checking, lots of misc. changes I don't remember
"
" TODO:
" - doArg,gotoArg highlighting
" - bad operator catches (&&, ||)
" - flag implementation specific intrinsics
" - highlight do/goto labels
 
" Remove any old syntax stuff hanging around
syn clear
syn sync    maxlines=1
syn sync    minlines=1
syn case    ignore
 
"errors
syn match   mError   contained /[^ \t;].\+/
syn match   mBadString  /".*/
" Catch mismatched parentheses
syn match   mParenError /).*/
syn match   mBadParen   /(.*/
 
" Line Structure
syn region  mComment contained start=/;/ end=/$/ contains=mTodo,@Spell
syn keyword mTodo contained todo xxx hack
syn match   mLabel   contained /^[%A-Z][A-Z0-9]*\|^[0-9]\+/ nextgroup=mFormalArgs
syn region  mFormalArgs contained oneline start=/(/ end=/)/ contains=mLocalName,","
syn match   mDotLevel   contained /\.[. \t]*/
syn region  mCmd  contained oneline start=/[A-Z]/ end=/[ \t]/ end=/$/ contains=mCommand,mZCommand,mPostCond,mError nextgroup=mArgsSeg
syn region  mPostCond   contained oneline start=/:/hs=s+1 end=/[ \t]/re=e-1,he=e-1,me=e-1 end=/$/ contains=@mExpr
syn region  mArgsSeg contained oneline start=/[ \t]/lc=1 end=/[ \t]\+/ end=/$/ contains=@mExpr,",",mPostCond
syn match   mLineStart  contained /^[ \t][. \t]*/
syn match   mLineStart  contained /^[%A-Z][^ \t;]*[. \t]*/ contains=mLabel,mDotLevel
syn region  mLine start=/^/ keepend end=/$/ contains=mCmd,mLineStart,mComment
syn cluster mExpr contains=mVar,mIntr,mExtr,mString,mParen,mOperator,mBadString,mBadNum,mVRecord,mComma
syn keyword mComma contained ,
CPHL mComma red red
syn match   mVar  contained /\^=[%A-Za-z][A-Z0-9]*/ nextgroup=mSubs
syn match   mIntr contained /$[&%A-Z][A-Z0-9]*/ contains=mIntrFunc,mSpecialVar,mExternRef nextgroup=mParams
syn match   mExtr contained /$$[%A-Z][A-Z0-9]*\(\^[%A-Z][A-Z0-9]*\)\=/ nextgroup=mParams
syn match   mLocalName  contained /[%A-Z][A-Z0-9]*/
syn match   mExternRef  contained /$\?&[%A-Z0-9.]\+/
 
" Operators
syn match   mOperator   contained "[+\-*/=&#!'\\\]<>?@]"
syn match   mOperator   contained "]]"
syn region  mVRecord contained start=/[= \t,]</lc=1 end=/>/ contains=mLocalName,","
 
" Constants
syn region  mString  contained oneline start=/"/ skip=/""/ excludenl end=/"/ oneline contains=@Spell
syn match   mBadNum  contained /\<0\d+\>/
syn match   mBadNum  contained /\<\d*\.\d*0\>/
syn match   mNumber  contained /\<\d*\.\d{1,9}\>/
syn match   mNumber  contained /\<\d+\>/
 
syn region  mParen   contained oneline start=/(/ end=/)/ contains=@mExpr
syn region  mSubs contained oneline start=/(/ end=/)/ contains=@mExpr,","
syn region  mActualArgs contained oneline start=/(/ end=/)/ contains=@mExpr,","
 
" note: case insensitivity is on, so we MUST use \u \l to match upper or lower case
" Mixed alpha / numeric: EA3LIB
syn match spellingException "\<\w*\d\+\w*\>"    transparent contained containedin=mComment,mString contains=@NoSpell
" All upper: ELIBIX
syn match spellingException "\<\u\+\>"          transparent contained containedin=mComment,mString contains=@NoSpell
" Starting with more than one upper: ADDme
syn match spellingException "\<\u\{2,}\w\+\>"   transparent contained containedin=mComment,mString contains=@NoSpell
" Mixed case with lower-case starting letter: libFn
syn match spellingException "\<\l\+\(\u\|\d\)\+\w*\>" transparent contained containedin=mComment,mString contains=@NoSpell
" Mixed case with upper-case starting letter: "NxtLibFnRou" but not "Dispay"
syn match spellingException "\<\u\+\(\l\|\d\)\+\u\w*\>" transparent contained containedin=mComment,mString contains=@NoSpell
" Ignore things like "*ARB", "$t", "%ZeLIBCM", "^glo"
syn match spellingException "[$*\^%][A-Z0-9]\+" transparent contained containedin=mComment,mString contains=@NoSpell
" Ignore things like "abc(" or "tag^" or "tag^routine"
syn match spellingException "\<\w\+("             transparent contained containedin=mComment,mString contains=@NoSpell
syn match spellingException "\<\w\+\^[A-Z0-9%]\+" transparent contained containedin=mComment,mString contains=@NoSpell
 
" Keyword definitions ------------------- {{{
"-- Commands --
syn keyword mCommand contained d do g goto
syn keyword mCommand contained c close e else f for h halt hang
syn keyword mCommand contained i if k kill l lock m merge n new q quit
syn keyword mCommand contained r read s set
syn keyword mCommand contained tc tcommit tre trestart tro trollback ts tstart
syn keyword mCommand contained u use w write x xecute
"-- Commands: Implementation specific --
syn keyword mZCommand   contained b break j job o open v view
syn keyword mZCommand   contained za zallocate zb zbreak zd zdeallocate
syn keyword mZCommand   contained zp zprint zk zkill zwrite
"-- Commands: GT.M specific --
syn keyword mZCommand   contained zwr
syn keyword mZCommand   contained zcom zcompile zc zcontinue
syn keyword mZCommand   contained zed zedit zg zgoto zh zhelp zl zlink zm zmessage
syn keyword mZCommand   contained zsh zshow zst zstep zsy zsystem ztc ztcommit zts ztstart
syn keyword mZCommand   contained zwi zwithdraw
 
"-- Intrinsic Functions --
syn keyword mIntrFunc   contained a ascii c char d data e extract f find fn fnumber g get
syn keyword mIntrFunc   contained j justify l length na name n next o order p piece
syn keyword mIntrFunc   contained ql qlength qs qsubscript q query r random re reverse
syn keyword mIntrFunc   contained s select st stack t text tr translate
"-- Intrinsic Functions: Implementation specific --
syn keyword mIntrFunc   contained i increment v view zd zdate zs zsearch zp zprevious
"-- Intrinsic Functions: GT.M --
syn keyword mIntrFunc   contained zm zmessage zparse ztrnlnm
syn keyword mIntrFunc   contained zbitand zbitcount zbitfind zbitget
syn keyword mIntrFunc   contained zbitlen zbitnot zbitor zbitset
syn keyword mIntrFunc   contained zbitstr zbitxor zqgblmod
syn keyword mIntrFunc   contained za zascii zc zchar ze zextract zf zfind
syn keyword mIntrFunc   contained zj zjustify zl zlength zp zpiece ztr ztranslate
syn keyword mIntrFunc   contained zco zconvert zsub zsubstr zw zwidth
syn keyword mIntrFunc   contained zgetjpi zsigproc
 
"-- Special Variables: GT.M --
syn keyword mSpecialVar contained r reference zcmd zcmdline zco zcompile zc zcstatus
syn keyword mSpecialVar contained zda zdateform zd zdirectory zed zeditor zeo zeof
syn keyword mSpecialVar contained zg zgbldir zint zinterrupt zini zininterrupt zio
syn keyword mSpecialVar contained zj zjob zl zlevel zmaxtpti zmaxtptime zmo zmode
syn keyword mSpecialVar contained zpos zposition zprom zprompt zro zroutines
syn keyword mSpecialVar contained zso zsource zs zstatus zst zstep zsy zsystem
syn keyword mSpecialVar contained zte ztexit zyer zyerror
syn keyword mSpecialVar contained zal zallocstor zch zchset zda zdateform zpatn zpatnumeric
syn keyword mSpecialVar contained zproc zprocess zq zquit zre zrealstor zus zusedstor
 " }}}

if !exists("did_m_syntax_inits")
  let did_m_syntax_inits = 1

  " The default methods for hilighting.  Can be overridden later
  hi! link mCommand  Statement
  hi! link mZCommand Statement
  hi! link mIntrFunc Statement
  hi! link mSpecialVar  Statement
  hi! link mLineStart   Statement
  hi! link mLabel Function
  hi! link mExternRef   Function
  hi! link mFormalArgs  PreProc
  hi! link mDotLevel PreProc
  hi! link mCmdSeg   Special
  hi! link mPostCond Special
  hi! link mCmd      Statement
  hi! link mArgsSeg  Special
  hi! link mExpr  PreProc
  hi! link mVar      Identifier

  if exists(':CPHL')
    CPHL mParen gray0 cyan
  else
    hi! link mParen Special
  endif

  hi! link mSubs  Special
  hi! link mActualArgs  Special
  "Change mIntr to Special to not highlight the "$" in "$tr"
  hi! link mIntr  Statement
  hi! link mExtr  Function
  hi! link mString   String
  hi! link mNumber   Number
  hi! link mOperator Operator
  hi! link mComment  Comment

  if exists(':CPHL')
    CPHL mError red gray2 -
  else
    hi! link mError Error
  endif

  hi! link mBadNum   Error
  hi! link mBadString   Error
  hi! link mBadParen Error
  hi! link mParenError  Error
  hi! link mTodo  Todo
endif
 
let b:current_syntax = "mumps"
