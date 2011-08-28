" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

if has("gui_gtk2")
    set guifont=Droid\ Sans\ Mono\ 10
elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h12           " Font family and font size.
end

set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set background=dark              " Background.
set lines=35 columns=100          " Window dimensions.

" Uncomment to use.
" set guioptions-=r                 " Don't show right scrollbar


