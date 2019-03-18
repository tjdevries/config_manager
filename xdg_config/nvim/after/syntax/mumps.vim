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


syn region  mComment contained start=/;/ end=/$/ contains=mTodo,@Spell
syn keyword mTodo contained todo xxx hack

" Start of function or tag
syn match   mLabel   contained /^[%A-Z][A-Z0-9]*\|^[0-9]\+/ nextgroup=mFormalArgs
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
" -- }}}
