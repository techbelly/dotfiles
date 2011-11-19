source ~/.vim/bundles.vim

syntax enable                     " Turn on syntax highlighting.

runtime macros/matchit.vim        " Load the matchit plugin.

" Vim settings {{{
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
set nohlsearch                      " Highlight matches.

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

set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

syntax on

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END 
" }}}

colorscheme solarized

" Keymappings {{{
nnoremap j gj
nnoremap k gk
nnoremap <leader>a :Ack 

inoremap jk <esc>

cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l

nnoremap H 0
nnoremap L $

noremap <space> /
noremap <c-space> ?

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>eb <C-w><C-v><C-l>:e $HOME/.vim/bundles.vim<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

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

nnoremap <leader>sc mqA;<esc>`q

" }}}

" Filetypes {{{
" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax smarttab shiftwidth=2 tabstop=2 softtabstop=4
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 nowrap go+=b smarttab softtabstop=4 

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufNewFile,BufRead *.json set ft=javascript
" }}}

so $HOME/.local.vim

" Command T {{{
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>bb :CommandTBuffer<CR>
let g:CommandTMatchWindowAtTop=1 " show window at top
let g:CommandTMaxHeight=20

if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    map <D-t> :CommandT<CR>
endif
" }}}

" Tlist {{{
nnoremap <leader>l :TlistToggle<CR>
let Tlist_Use_Right_Window = 1 
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let tlist_objc_settings = 'ObjectiveC;i:interface;c:class;m:method;p:property;I:implementation'
" }}}

" NERDTree ------ {{{
let g:NERDTreeIgnore=['\.pyc$','\~$']
noremap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
augroup nerdtree
  au!
  au VimEnter *  NERDTree
augroup END
" }}}

" Vimscript ---------------------- {{{
augroup filetype_vim
  au!
  au FileType vim setlocal foldmethod=marker foldenable
augroup END
" }}}

" EasyMotion ------------------- {{{
let g:EasyMotion_mapping_w = '<Leader>m'
let g:EasyMotion_mapping_W = '<Leader>M'
let g:EasyMotion_mapping_t = '<Leader>d'
let g:EasyMotion_mapping_b = '<Leader>z'
" }}}

" Gist-vim --- {{{
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
" }}}

