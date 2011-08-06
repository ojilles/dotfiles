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

map  :w!<CR>:!aspell --home-dir ~/jilles.net/_bin -p custom_dict.aspell check %<CR>:e! %<CR>   
