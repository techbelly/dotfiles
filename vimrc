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
set hlsearch                      " Highlight matches.

set gdefault
set nowrap                          " Turn on line wrapping.
set scrolloff=7                   " Show 3 lines of context around the cursor.
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

set background=light
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

set clipboard=unnamed

syntax on

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END 
" }}}

" Statusline {{{
augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.
 
set statusline+=\    " Space.

set statusline+=%#redbar#                " Highlight the following as a warning.
set statusline+=%*                           " Reset highlighting.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c)

" }}}

set background=dark
colorscheme solarized

" Keymappings {{{

" up and down is up and down
nnoremap j gj
nnoremap k gk

nnoremap <leader>a :Ack 

inoremap jk <esc>


" Emacs Heresy
inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

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

map ; :
noremap ;; ;

nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>eb <C-w><C-v><C-l>:e $HOME/.vim/bundles.vim<cr>
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

"Insert a semicolon at the end of a line
nnoremap <leader>sc mqA;<esc>`q

nnoremap <leader><leader> <C-^>
" }}}

" Rails shortcuts {{{
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . _ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
" }}}

" Filetypes {{{
" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax smarttab shiftwidth=2 tabstop=2 softtabstop=4
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4 nowrap go+=b smarttab softtabstop=4 

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufNewFile,BufRead *.json set ft=javascript
au BufRead,BufNewFile *.json set filetype=json foldmethod=syntax
au FileType json command -range=% -nargs=* Tidy <line1>,<line2>! json_xs -f json -t json-pretty
" }}}
au BufRead,BufNewFile *.go set filetype=go

so $HOME/.local.vim

" Command T {{{
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>bb :CommandTBuffer<CR>
let g:CommandTMatchWindowAtTop=1 " show window at top
let g:CommandTMaxHeight=20

if has("gui_macvim")
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
  au VimEnter * wincmd p
augroup END
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" " buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
      if bufwinnr(t:NERDTreeBufName) != -1
          if winnr("$") == 1
                q
          endif
      endif
  endif
endfunction

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

if &term =~ "xterm-256color"
  set t_Co=256
  set t_SI = "\<Esc>]12;purple\x7"
  set t_EI = "\<Esc>]12;blue\x7"
endif

function! RunBuildCommand(cmd)
  let l:BuildLog = "build/vim.log"
  if bufname("%") != ""
    silent write
  endif
  echo "Building... "
  let l:StartTime = reltime()
  exec "silent !" . a:cmd . " >" . l:BuildLog . " 2>&1"

  " xcodebuild does NOT set exit code properly, so check the build log
  exec "silent !grep -q '^\*\* BUILD FAILED' " . l:BuildLog
  redraw!
  if !v:shell_error
    set errorformat=
      \%f:%l:%c:{%*[^}]}:\ error:\ %m,
      \%f:%l:%c:{%*[^}]}:\ fatal\ error:\ %m,
      \%f:%l:%c:{%*[^}]}:\ warning:\ %m,
      \%f:%l:%c:\ error:\ %m,
      \%f:%l:%c:\ fatal\ error:\ %m,
      \%f:%l:%c:\ warning:\ %m,
      \%f:%l:\ Error:\ %m,
      \%f:%l:\ error:\ %m,
      \%f:%l:\ fatal\ error:\ %m,
      \%f:%l:\ warning:\ %m
    execute "cfile! " . l:BuildLog
  else
    echo "Building... OK - " . reltimestr(reltime(l:StartTime)) . " seconds"
  endif
endfunction

