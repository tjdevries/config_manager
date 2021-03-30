scriptencoding utf-8

" TODO:
"   Make a mapping that I like for helpclose
"   Make a better mapping to jump back to last buffer <c-^>

" This is where most of my basic keymapping goes.
"
"   Plugin keymaps will all be found in `./after/plugin/*`

nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
" Switch between tabs
nnoremap <Right> gt
nnoremap <Left>  gT

inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

" Opens line below or above the current line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O


" call describe("mode", "remap", ...)
" idescribe <Up>  " description.
" inoremap <expr> <describe> my mapping here other stuff<CR> """ asdf
" inoremap <describe> asdf my mapping here other stuff<CR>
"       \ <description> asdf


" Set kj to be escape in insert mode
inoremap kj <esc>

" Does:
"   For wrapped lines, does gj/gk
"   For large jumps, adds a spot on the jump list
function! s:jump_dir(letter)
  let jump_count = v:count

  if jump_count == 0
    return execute(printf('normal! g%s', a:letter))
  endif

  if jump_count > 5
    normal! m'
  endif

  call execute(printf('normal! %d%s', jump_count, a:letter))
endfunction
nnoremap <silent> j <cmd>call <SID>jump_dir('j')<CR>
nnoremap <silent> k <cmd>call <SID>jump_dir('k')<CR>

" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" Thanks to: http://vi.stackexchange.com/a/213
nnoremap <silent> gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
nnoremap <silent> gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

" Run the last command
nnoremap <leader><leader>c :<up>

" Map execute this line
function! s:executor() abort
  if &ft == 'lua'
    call execute(printf(":lua %s", getline(".")))
  elseif &ft == 'vim'
    exe getline(">")
  endif
endfunction
nnoremap <leader>x :call <SID>executor()<CR>

vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>
nnoremap <leader><leader>v :w<CR>:Vader %<CR>

" Execute this file
nnoremap <leader><leader>x :call tj#save_and_exec()<CR>

" Remove whitespace
nnoremap <leader>sws :%s/\s\+$//<CR>

" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make windows to be basically the same size
nnoremap <leader>= <C-w>=

" Sizing window horizontally
nnoremap <c-,> <C-W><
nnoremap <c-.> <C-W>>
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>

" Sizing window vertically
" taller
nnoremap <A-t> <C-W>+
" shorter
nnoremap <A-s> <C-W>-

" Move easily to the next error
nnoremap <leader>l :lnext<CR>
nnoremap <leader>h :lprevious<CR>

" Fun C to write the result of a command at the end of the function
" function signature
nnoremap <leader>fs ^yt{$%"_ddI} /* <esc>pa*/<CR><esc>

" Get autoload names easily
imap <leader>au auto,e

" Undo toggle
nnoremap <leader>ut :GundoToggle<cr>

" Random number into vim
inoremap <leader>nr <c-o>:py import vim, random; vim.current.line += str(random.randint(0,9))<CR><esc>A

" Helpful delete/change into blackhole buffer
nmap <leader>d "_d
nmap <leader>c "_c
nmap <space>d "_d
nmap <space>c "_c

" Change the working directory for everybody
nnoremap <leader>cd :windo lcd 

if has('nvim')
    " Make esc leave terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <Esc><Esc> <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l

    " Try and make sure to not mangle space items
    tnoremap <S-Space> <Space>
    tnoremap <C-Space> <Space>
endif

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

if v:false
  " TODO: Explore why I wrote this for someone and why I thought it was good.
  augroup complete_tab_search
    autocmd!
    autocmd CmdlineEnter /,\? :set incsearch
    autocmd CmdlineLeave /,\? :set noincsearch

    autocmd CmdlineEnter /,\? :cnoremap <TAB> <C-R><C-W>
    autocmd CmdlineLeave /,\? :cunmap <TAB>
  augroup END
endif


" Change the current word in insertmode.
"   Auto places you into the spot where you can start typing to change it.
nnoremap <c-w><c-r> :%s/<c-r><c-w>//g<left><left>

nnoremap <M-CR> :let v:hlsearch=!v:hlsearch<CR>

" Shrug ¯\_(ツ)_/¯
inoremap ,shrug ¯\_(ツ)_/¯

" My own modeline
nnoremap <leader>m :call execute(substitute(getline('.'), '.*vim', '', ''))<CR>

nnoremap <leader><leader>n :normal!<space>

" Basically commandline fixes for fat fingering
cnoremap %:H %:h

" But really I should use these instead
cnoremap %H <C-R>=expand('%:h:p') . std#path#separator()<CR>
cnoremap %T <C-R>=expand('%:t')<CR>
cnoremap %P <C-R>=expand('%:p')<CR>
cnoremap E<S-space> e<space>

" " Break undo sequence on specific characters
" inoremap , ,<C-g>u
" inoremap . .<C-g>u
" inoremap ! !<C-g>u
" inoremap ? ?<C-g>u

" Move line(s) up and down
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
