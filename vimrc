execute pathogen#infect()
syntax on
filetype plugin indent on
set ruler
set ts=2

" Search stuff
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch

" Setup highlight of trailing whitespace
highlight ExtraWhitespace ctermbg=blue
map <leader>w :match ExtraWhitespace /\s\+$/<cr>

" Retur to last edit position when opening files (You want this!)
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
" Remember info about open buffers on close
set viminfo^=%

" Next bit is from: https://github.com/mnazim/dotfiles/blob/master/vim/vimrc
" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Turn off annoying swapfiles
set noswapfile

" Prefer unix over windows over os9 formats
set fileformats=unix,dos,mac

" http://blog.gopheracademy.com/vimgo-development-environment
" From: https://github.com/fatih/vim-go
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-implements)

map <leader>ss :setlocal spell!<cr>

" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" :W sudo saves the file
" " (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
