"
" ~/.vimrc
"

" Use filetype based syntax highlighting
filetype off
filetype plugin on
syntax on

" Wrap around cursor movement
set whichwrap=b,s,<,>,[,]

" Show line numbers and lengths
set number
set tw=78
set nowrap
set colorcolumn=80
set ruler

" Show command multiplier
set showcmd

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Enable auto-indent
set autoindent
set smartindent

" Configure tab behaviour: 2 spaces, expanded
set expandtab
set shiftwidth=2
set tabstop=2

" Highlight trailing whitespace in red and show char
match ErrorMsg /\s\+\%#\@<!$/
set list listchars=tab:»·,trail:·,nbsp:·

" Ignore case while searching
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Return to the last edit position when opening files except commit messages
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Powerline
set rtp+=/home/toxygeneb/.local/lib/python3.5/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Shell to use with :shell :sh
set shell=/bin/bash

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Toggle paste mode for preserving indentation of pasted text
set pastetoggle=<F2>
set clipboard=unnamed

