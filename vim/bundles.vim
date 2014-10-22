set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'

Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'

Plugin 'altercation/vim-colors-solarized'
Plugin 'vividchalk.vim'

Plugin 'Lokaltog/vim-powerline'

Plugin 'tikhomirov/vim-glsl'
Plugin 'ujihisa/vim-markdown'
Plugin 'fatih/vim-go'
Plugin 'timcharper/textile.vim'

call vundle#end()
filetype plugin indent on 
