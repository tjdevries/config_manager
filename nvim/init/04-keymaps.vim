Describe nnoremap <Up>          :echom "--> k <-- "<CR> >>> Silly boy, that's now how you move
Describe nnoremap <Down>        :echom "--> j <-- "<CR> >>> Silly boy, that's now how you move
Describe nnoremap <Right>       :echom "--> l <-- "<CR> >>> Silly boy, that's now how you move
Describe nnoremap <Left>        :echom "--> h <-- "<CR> >>> Silly boy, that's now how you move

Describe inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
Describe inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
Describe inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
Describe inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

" Set kj to be escape in insert mode
Describe inoremap kj <esc>

" For long, wrapped lines
Describe nnoremap k gk
Describe nnoremap j gj

" Map execute this line
Describe nnoremap <leader>x :exe getline(".")<CR>
Describe vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>

" Remove whitespace
nnoremap <leader>sws :%s/\s\+$//<CR>

" Easier Moving between splits
Describe nnoremap <C-J> <C-W><C-J>
Describe nnoremap <C-K> <C-W><C-K>
Describe nnoremap <C-L> <C-W><C-L>
Describe nnoremap <C-H> <C-W><C-H>

" Move easily to the next error
Describe nnoremap <leader>l :lnext<CR>
Describe nnoremap <leader>h :lprevious<CR>

if has('nvim')
    " Make esc leave terminal mode
    Describe tnoremap <Esc> <C-\><C-n>
    tnoremap kj <C-\><C-n>

    " Easy moving between the buffers
    Describe tnoremap <A-h> <C-\><C-n><C-w>h
    Describe tnoremap <A-j> <C-\><C-n><C-w>j
    Describe tnoremap <A-k> <C-\><C-n><C-w>k
    Describe tnoremap <A-l> <C-\><C-n><C-w>l
    Describe nnoremap <A-h> <C-w>h
    Describe nnoremap <A-j> <C-w>j
    Describe nnoremap <A-k> <C-w>k
    Describe nnoremap <A-l> <C-w>l
endif
