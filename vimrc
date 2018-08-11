" begin of Vundle package management
" To install bundles, type :BundleInstall
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-syntastic/syntastic'
Plugin 'c.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/scons.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'pangloss/vim-javascript'
Plugin 'cespare/vim-toml'

call vundle#end()
" end of Vundle

" securities for custom .vimrc
set exrc
set secure

" switch interpreter for jedi-vim, syntastic and YCM to adapt Python 3
let g:jedi#force_py_version = 3
let g:syntastic_python_python_exec = 'python3'
let g:ycm_server_python_interpreter = 'python3'

" enable mouse
set mouse=a

" keymaps
let mapleader = "\<Space>"
inoremap jj <ESC>
vnoremap . :norm.<CR>
nnoremap Y y$
map <leader>x :NERDTree<CR>

" easy navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" set theme for vim-airline
let g:airline_theme = 'solarized'

" fix backspace bug (somehow happened, but don't know why)
set backspace=indent,eol,start

" for YCM C/C++ autocomplete
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
