set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'dylanaraps/wal.vim'

call plug#end()

filetype plugin indent on

syntax on
set t_Co=256

set laststatus=2
set encoding=utf8
set noshowmode
set wildmenu
set backspace=2
set visualbell
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set ttyfast
set mouse=a
set list listchars=tab:»·,trail:·,nbsp:·
set number
set cursorline
set nowrap

colorscheme wal

hi EndOfBuffer ctermfg=NONE
hi LineNr term=bold cterm=NONE ctermfg=7 ctermbg=NONE
hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
hi CursorLineNR cterm=NONE ctermbg=9 ctermfg=NONE

let &t_SI = "\<Esc>[5 q"
let g:airline_powerline_fonts = 1
