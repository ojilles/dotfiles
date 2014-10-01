execute pathogen#infect()
syntax on
filetype plugin indent on

" Next bit is from: https://github.com/mnazim/dotfiles/blob/master/vim/vimrc
" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Turn off annoying swapfiles
set noswapfile

" Prefer unix over windows over os9 formats
set fileformats=unix,dos,mac

" Enable mouse
set mouse=a

" From: https://github.com/fatih/vim-go
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-implements)
