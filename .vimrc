source $VIMRUNTIME/vimrc_example.vim
set rtp+=/usr/lib/python3.6/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256
set clipboard=unnamed
set encoding=utf8
set pastetoggle=<F3>
filetype plugin indent on
set autoindent
set tabstop=4
set expandtab
set number
syntax on
colorscheme default
if has('gui_running')
    " GUI colors
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
    colorscheme desert
    set guifont=Noto\ Mono\ For\ Powerline\ Regular
else
    " Non-GUI (terminal) colors
    colorscheme default
endif
au BufRead,BufNewFile *.dart set filetype=dart

function! Sanitize()
    let l:save = winsaveview()
    %s/\s\+$//e
    %s/\t/    /ge
    call winrestview(l:save)
    echo "Cleaned up file"
endfunction

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Clear selection
map <silent> <leader><cr> :noh<cr>
