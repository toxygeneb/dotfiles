" ~/.vimrc

" Fix Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Editor Window
set autoindent
set nu
set showcmd
syntax on
filetype plugin indent on

" Plugin Manager
" (install plugins under ~/.vim/bundle; automatically added to 'runtimepath'
execute pathogen#infect()

