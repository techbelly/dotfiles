set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.
set nofoldenable
set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set gdefault
set nowrap                          " Turn on line wrapping.
set scrolloff=7                   " Show 3 lines of context around the cursor.

set listchars=tab:▸\ ,eol:¬,trail:.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set noswapfile
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set autoindent
set expandtab

set laststatus=2                  " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set background=dark
set pastetoggle=<F2>

let mapleader = ","

set showmatch

set encoding=utf-8
set fileencoding=utf-8
set spelllang=en_GB.UTF-8

set guioptions=
set cursorline


nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <leader>a :Ack 

cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l


map <space> /
map <c-space> ?

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax smarttab shiftwidth=2 tabstop=2 softtabstop=4
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 nowrap go+=b smarttab softtabstop=4 

so $HOME/.local.vim

map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>

nmap <C-Up> ddkP
nmap <C-Down> ddp
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

Bundle 'taglist.vim'

nnoremap <leader>t :TlistToggle<CR>
let Tlist_Use_Right_Window = 1 
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1

Bundle "nathanaelkane/vim-indent-guides"
Bundle "mileszs/ack.vim"
Bundle "scrooloose/nerdcommenter"
Bundle "fs111/pydoc.vim"
Bundle "vim-scripts/Gist.vim"
Bundle "tpope/vim-surround"
Bundle "Lokaltog/vim-easymotion"    
Bundle "tpope/vim-git"
Bundle "ujihisa/vim-markdown"
Bundle "timcharper/textile.vim")
Bundle "altercation/vim-colors-solarized"

colorscheme solarized

Bundle "wycats/nerdtree"
let NERDTreeIgnore=['\.pyc$','\~$']
map <leader>n :NERDTreeToggle<CR>
set NERDTreeChDirMode = 2

au VimEnter *  NERDTree

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

set antialias
set guifont=Consolas:h14

let g:EasyMotion_mapping_w = '<Leader>m'
let g:EasyMotion_mapping_W = '<Leader>M'
let g:EasyMotion_mapping_t = '<Leader>d'


syntax on
