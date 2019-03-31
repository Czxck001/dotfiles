" begin of Vundle package management
" To install bundles, type :BundleInstall
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/c.vim'
Plug 'davidhalter/jedi-vim'
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/scons.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'cespare/vim-toml'

call plug#end()
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

" coc.nvim
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use <cr> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" To make <cr> select the first completion item and confirm completion when no item have selected:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" /coc.nvim

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

" Open NERDTree in new tabs and windows if no command line args set
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if !argc() | NERDTreeMirror | endif
autocmd VimEnter * wincmd w
