set background=dark
colorscheme solarized
syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set tw=79

set ignorecase

set incsearch
map <F5> {!}fmt

set ruler
set showcmd


" Next bit is from: https://github.com/mnazim/dotfiles/blob/master/vim/vimrc
" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Turn off annoying swapfiles
set noswapfile

" Set persistent undo (v7.3 only)
"set undodir=~/.vim/undodir
"set undofile

" Make the command line two lines high and change the statusline display to
" something that looks useful.
set showcmd
set showmode
set number

" Prefer unix over windows over os9 formats
set fileformats=unix,dos,mac


" markdown
" ---
autocmd BufNewFile,BufRead *.txt,*.markdown,*.md setlocal ft=markdown 

" Map in spelling correction
map  :w!<CR>:!aspell --home-dir ~/jilles.net/_bin -p custom_dict.aspell check %<CR>:e! %<CR>   


" Put on the training wheels:
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
