
" Vim settings {{{

syntax enable                     " Turn on syntax highlighting.
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

set wrap                        " Turn on line wrapping.
set scrolloff=7                   " Show lines of context around the cursor.
set winwidth=80

set listchars=tab:▸\ ,eol:¬,trail:.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set equalalways

set noswapfile
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set autoindent
set expandtab

set laststatus=2                  " Show the status line all the time

set pastetoggle=<F2>

let mapleader = ","
nnoremap \ ,
set showmatch

set encoding=utf-8
set fileencoding=utf-8
set spelllang=en_GB.UTF-8

set guioptions=
set cursorline

set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

filetype plugin on

" }}}

" Plugins {{{
call plug#begin()
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'pangloss/vim-javascript'
Plug 'vim-airline/vim-airline.git'
Plug 'dense-analysis/ale.git'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'vimwiki/vimwiki.git'
call plug#end()
" }}}
"
" Syntax {{{
" Highlight tabs (if expandtab is set)

autocmd BufNewFile,BufReadPost *
  \ if &expandtab |
  \   syn match Tab "\t" |
  \ endif

" Highlight whitespace errors
autocmd BufNewFile,BufReadPost * syn match TrailingWS "\s\+$"

" Strip whitespace
autocmd FileType elm,ruby,rb,py autocmd BufWritePre <buffer> %s/\s\+$//e

" }}}

" Theming {{{
syntax on

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END 

set background=dark
set t_Co=256
set cursorline
colorscheme onehalfdark

" }}}

" Keymappings {{{

" up and down is up and down
nnoremap j gj
nnoremap k gk

nnoremap <leader>a :Ack 

inoremap jk <esc>
inoremap § <esc>

" select a buffer
nnoremap <leader>b :ls<cr>:b<space>

" Emacs Heresy
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

nnoremap <leader>m <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l

nnoremap H 0
nnoremap L $

noremap <space> /
noremap <c-space> ?

nnoremap <leader><space> :noh<cr>

nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>


" Edit files in the same folder as the current one.
noremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <C-Up> ddkP
nnoremap <C-Down> ddp
vnoremap <C-Up> xkP`[V`]
vnoremap <C-Down> xp`[V`]

noremap <D-[> <<
noremap <D-]> >>
vnoremap <D-[> <gv
vnoremap <D-]> >gv

nnoremap <leader>n :lnext<CR>
nnoremap <leader>N :lrewind<CR>

" keep selection after in/outdent
vnoremap < <gv
vnoremap > >gv

"Insert a semicolon at the end of a line
nnoremap <leader>sc mqA;<esc>`q

"Remove trailing whitespace
nnoremap <leader>ws :s/\s\+$//e<CR>

"Insert spaces after commas
nnoremap <leader>z :s/\v([^ ]),([^ ])/\1, \2/g<cr>

" Edit alternative file
nnoremap <leader><leader> <C-^>

" }}}

" Filetypes {{{
" Automatic fold settings for specific files. Uncomment to use.
augroup file_settings
  au!
  autocmd FileType ruby setlocal foldmethod=syntax smarttab shiftwidth=2 tabstop=2 softtabstop=4
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

  au FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
  au FileType python setlocal expandtab shiftwidth=4 tabstop=8 textwidth=79 go+=b autoindent softtabstop=4 

  au FileType vim setlocal foldmethod=marker foldenable

  au BufNewFile,BufRead *.json set ft=javascript
  au BufNewFile,BufRead *.js set ft=javascript
  au BufNewFile,BufRead *.jsx set ft=javascript
  au BufRead,BufNewFile *.json set filetype=json foldmethod=syntax
  au BufRead,BufNewFile *.go set filetype=go
  au BufNewFile,BufReadPost *.md set filetype=markdown
  au BufRead,BufNewFile *.html let g:ale_fix_on_save=1 
  au BufRead,BufNewFile *.js let g:ale_fix_on_save=1 
  au BufRead,BufNewFile *.jsx let g:ale_fix_on_save=1 
  au BufRead,BufNewFile *.jsx let g:ale_fixers = {'javascript': ['prettier', 'eslint'] }
  au BufRead,BufNewFile *.elm let g:ale_fix_on_save=1 
  au BufRead,BufNewFile *.elm let g:ale_fixers= { 'elm': ['elm-format'] }
augroup END
" }}}


" {{{ Mouse and terminal
if has('mouse')
  set mouse=a
  augroup mouse_settings 
    autocmd!
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  augroup END
endif"
" }}}

" {{{ Airline
let g:airline_theme='onehalfdark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
" }}}

" ALE {{{ 
let g:ale_list_window_size = 5
" }}}

" Smooth-scroll {{{
if has('smooth_scroll')
  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
  noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
  noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
endif
" }}}

" Linting {{{
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\}
" }}}

" Fuzzy Finder {{{
set rtp+=/usr/local/opt/fzf
nnoremap <leader>f :FZF<CR>
" }}}

" Ag / Ack {{{
if executable("ag") 
  let g:ackprg="ag --nogroup --nocolor --column" 
  set grepprg=ag\ --vimgrep\ $* 
  set grepformat=%f:%l%c%m 
endif
" }}}

" Run tests {{{
nnoremap <silent> <leader>r :term bundle exec rspec %<cr>
nnoremap <silent> <leader>R :term bundle exec rake<cr>
" }}}

