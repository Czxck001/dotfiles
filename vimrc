" begin of Vundle package management
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'c.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'valloric/youcompleteme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/scons.vim'

call vundle#end()
" end of Vundle

" securities for custom .vimrc
set exrc
set secure

" enable mouse
set mouse=a

" keymaps
let mapleader='\<Space>'
inoremap jj <ESC>
vnoremap . :norm.<CR>
map x :NERDTree<CR>

" editors
syntax enable
set encoding=utf-8
set number
set colorcolumn=80
set clipboard=unnamed

" tabs and spaces
filetype plugin indent on
set tabstop=2
set expandtab
set shiftwidth=2

" automatically remove trailing space on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" set theme
set background=dark
colorscheme solarized

" fix backspace bug (somehow happened, but don't know why)
set backspace=indent,eol,start

" for YCM C/C++ autocomplete
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
