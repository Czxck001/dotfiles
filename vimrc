set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'tag': 'v0.0.78'}
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/scons.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'drmikehenry/vim-headerguard'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'chiphogg/vim-prototxt'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'adelarsq/vim-matchit'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tommcdo/vim-exchange'
Plug 'rhysd/clever-f.vim'
Plug 'markonm/traces.vim'
Plug 'itchyny/vim-cursorword'

call plug#end()
" end of vim-plug

" securities for custom .vimrc
set exrc
set secure

" switch interpreter for syntastic to Python 3
let g:syntastic_python_python_exec = 'python3'

" enable mouse
set ttymouse=xterm2
set mouse=a

" keymaps
let mapleader = "\<Space>"
inoremap jj <ESC>
vnoremap . :norm.<CR>
nnoremap Y y$
map <leader>x :NERDTreeTabsToggle<CR>

" easy navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" editors
syntax enable
set encoding=utf-8
set number
set colorcolumn=88
"set clipboard=unnamed,unnamedplus,exclude:cons\\\\|linux

" Setting up Vim to yank to clipboard on Mac OS X
" See https://www.markcampbell.me/2016/04/12
"  /setting-up-yank-to-clipboard-on-a-mac-with-vim.html
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed  " copy to the system clipboard
  if has("unnamedplus")  " X11 support
    set clipboard+=unnamedplus
  endif
endif

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

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

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

" Remap keys for gotos
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop') <CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" /coc.nvim

" set theme
set background=dark
colorscheme solarized

" airline#tabline
let g:airline#extensions#tabline#enabled = 1

" set theme for vim-airline
let g:airline_theme='atomic'
"let g:airline_theme='zenburn'
"let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'

" fix backspace bug (somehow happened, but don't know why)
set backspace=indent,eol,start

" Open NERDTree at bootup
let g:nerdtree_tabs_open_on_console_startup=1

" Prevent Vim from indenting line when typing a colon (:) in Python
" https://stackoverflow.com/questions/19320747/prevent-vim-from-indenting-line-when-typing-a-colon-in-python
set indentkeys-=:

" Custom header guard for hpp.
function! g:HeaderguardName()
  return "INC_" . toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g')) . "_"
endfunction

" fzf.vim
command F Files

" Floaterm
let g:floaterm_autoclose=2  " Always auto-close window.
command T FloatermNew
command B FloatermNew broot

" tab controls
nnoremap <silent> <C-o> :tabprev<CR>
nnoremap <silent> <C-p> :tabnext<CR>
nnoremap <silent> <C-t> :tabnew<CR>

" vim-visual-multi
" Q: exit visual-multi
nmap <C-K> <C-Up>
nmap <C-J> <C-Down>
