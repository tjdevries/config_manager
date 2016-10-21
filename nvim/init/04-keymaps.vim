nnoremap <Up>          :echom "--> k <-- "<CR>
nnoremap <Down>        :echom "--> j <-- "<CR>
nnoremap <Right>       :echom "--> l <-- "<CR>
nnoremap <Left>        :echom "--> h <-- "<CR>

inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

" Set kj to be escape in insert mode
inoremap kj <esc>

" For long, wrapped lines
nnoremap k gk
nnoremap j gj

" For moving quickly up and down,
" Thanks to: http://vi.stackexchange.com/a/213
nnoremap gj /\%<C-R>=virtcol(".")<CR>v\S<CR>
nnoremap gk ?\%<C-R>=virtcol(".")<CR>v\S<CR>

" Map execute this line
nnoremap <leader>x :exe getline(".")<CR>
vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>

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

" Edit alternate file
nnoremap <leader>ea :e #<CR>

" Undo toggle
nnoremap <leader>ut :GundoToggle<cr>

" Random number into vim
inoremap <leader>rn <c-o>:py import vim, random; vim.current.line += str(random.randint(0,9))<CR><esc>A

" Helpful delete/change into blackhole buffer
nmap <leader>d "bd
nmap <leader>c "bc

if has('nvim')
    " Make esc leave terminal mode
    tnoremap <Esc> <C-\><C-n>
    tnoremap kj <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

