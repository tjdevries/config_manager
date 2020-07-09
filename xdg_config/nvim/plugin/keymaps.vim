scriptencoding utf-8

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

" For long, wrapped lines
nnoremap k gk
" For long, wrapped lines
nnoremap j gj

" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" Thanks to: http://vi.stackexchange.com/a/213
nnoremap gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
nnoremap gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

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
function! s:save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif

  return
endfunction
nnoremap <leader><leader>x :call <SID>save_and_exec()<CR>

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
    tnoremap <Esc> <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

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

nnoremap <M-CR> :let v:hlsearch=!v:hlsearch<CR>

nnoremap J :call tj#join_lines()<CR>

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
