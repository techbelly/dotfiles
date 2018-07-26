
" set runtimepath+=~/.vim/localfiles/
" source ~/.vim/bundles.vim

" Syntax {{{
" Highlight tabs (if expandtab is set)

autocmd BufNewFile,BufReadPost *
  \ if &expandtab |
  \   syn match Tab "\t" |
  \ endif

" Highlight whitespace errors
autocmd BufNewFile,BufReadPost * syn match TrailingWS "\s\+$"

" }}}

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

set nowrap                        " Turn on line wrapping.
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

" }}}

" Theming {{{
syntax on

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END 
set background=light
colorscheme solarized 
let g:solarized_termcolors=256
let g:solarized_termtrans =16
let g:solarized_contrast = "high"

" }}}

" Statusline {{{
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
set laststatus=2
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

nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>eb <C-w><C-v><C-l>:e $HOME/.vim/bundles.vim<cr>
nnoremap <silent> <leader>et <C-w><C-v><C-l>:e $HOME/.temp.vim<CR>
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

  autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 textwidth=79 go+=b autoindent softtabstop=4 
  autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e

  autocmd FileType python call GrepMap("<F5>",
        \"pep8 --repeat",
        \'\%f:\%l\%m',
        \"PEP8 correct")
  autocmd FileType python call GrepMap("<F6>", 
        \'pylint --reports=n --output-format=parseable --generated-members=objects,DoesNotExist -d C0111 -d C0301',
        \'\%f:\%l: [\%t\%*[^]]] \%m,\%f:\%l: [\%t] \%m',
        \'Pylint Correct')
  autocmd FileType python call GrepMap(",R",
        \'./manage.py jtest 2>&1 && echo',
        \'File \%f, line \%l, in \%m',
        \'Tests run ok')
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
  au BufNewFile,BufRead *.json set ft=javascript
  au BufRead,BufNewFile *.json set filetype=json foldmethod=syntax
  au BufRead,BufNewFile *.go set filetype=go
augroup END
" }}}

" NERDTree ------ {{{
if has('nerdtree')
  let g:NERDTreeIgnore=['\.pyc$','\~$']
  let g:NERDTreeChDirMode=2
  augroup nerdtree
    au!
    au VimEnter *  NERDTree
    au VimEnter * wincmd p
  augroup END
  autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
endif

"" Close all open buffers on entering a window if the only
"" " buffer that's left is the NERDTree buffer
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

" Gist-vim --- {{{
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
" }}}

" {{{ Mouse and terminal
set term=builtin_ansi
set t_Co=256
" "if &term =~ "xterm-256color""
"   set t_SI = "\<Esc>]12;purple\x7"
"   set t_EI = "\<Esc>]12;blue\x7"
" endif

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
let g:airline_theme="solarized"
let g:airline_left_sep = ""
let g:airline_right_sep = ""
" }}}

" Ctags {{{
nnoremap <f5> :call system('ctags --tag-relative -Rf "'.b:git_dir.'/tags"')<CR>

autocmd BufWritePost *
      \ if exists('b:git_dir') |
      \   call system('ctags --tag-relative -R -f "'.b:git_dir.'/tags" &') |
      \ endif
" }}}

" Unite.vim {{{
  if has('unite')
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    let g:unite_source_history_yank_enable = 1
    nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert git_cached<cr>
    nnoremap <leader>g :<C-u>Unite -no-split -buffer-name=files git_modified<cr>
    nnoremap <leader>m :<C-u>Unite -no-split -buffer-name=files git_untracked<cr>
    " nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
    nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
    nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

    " Custom mappings for the unite buffer
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      " Enable navigation with control-j and control-k in insert mode
      imap <buffer> <C-j>   <Plug>(unite_select_next_line)
      imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    endfunction
  endif 
" }}}

" Syntactic {{{

let g:syntastic_python_checkers = ['pylint', 'pep8']
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_pylint_args = '--rcfile='.$HOME.'/.pylintrc' 
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 1
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
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
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
