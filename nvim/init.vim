set nocompatible "It's like a shebang of the vim 21st century - anon

let is_win = has("win64") || has("win32") || has("win16")

" == Plugins {{{
if !is_win
  let nvim_config = "~/.config/nvim"
  let nvim_plug = "~/.local/share/nvim/site/autoload/plug.vim"
  let nvim_plug_libs = "~/.local/share/nvim/plugged"
else
  let nvim_config = $localappdata."/nvim"
  let nvim_plug = $localappdata."/nvim/autoload/plug.vim"
  let nvim_plug_libs = $localappdata."/nvim-data/plugged"
endif

if empty(glob(nvim_plug))
  silent execute '!curl -fLo '.nvim_plug .' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin(nvim_plug_libs)

" utilities and themes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'ghifarit53/tokyonight-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

if !is_win
  Plug 'lambdalisue/suda.vim'
endif
call plug#end()
"}}}

" == general options == "{{{

let g:mapleader = "\<Space>"

filetype plugin indent on
syntax on

if !has('gui_running')
  set t_Co=256
endif

set backspace=indent,eol,start
set clipboard+=unnamedplus
set cursorline
set emoji
set encoding=utf8
set expandtab smarttab
set foldmethod=marker
set incsearch ignorecase smartcase hlsearch
set laststatus=2
set list listchars=tab:»·,trail:·,nbsp:·
set mouse=a
set noshowmode
set nowrap
set number
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set termguicolors
set undofile
set visualbell
if is_win
  set undodir=$TMP
else
  set undodir=/tmp
endif

"}}}

" == custom key == "{{{

" auto unhighlight at double esc
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR>
" open terminal (space + enter)
nnoremap <silent> <leader><CR> :rightbelow 5sp new<CR>:terminal<CR>
" open netrw (space + e)
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
" open fzf (space + space)
nnoremap <silent> <leader><leader> :Files<CR>

"}}}

" == themes and UI vars == "{{{

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
colorscheme tokyonight

let g:airline_powerline_fonts = 1
let g:airline_theme = "tokyonight"
let g:airline_skip_empty_sections = 1

"}}}

" == NERDTree == {{{

let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = nvim_config . "/NERDTreeBookmarks"
let g:NERDTreeWinSize = 28
let g:NERDTreeChDirMode = 2
let g:NERDTreeDirArrowExpandable=""
let g:NERDTreeDirArrowCollapsible=""

"}}}

" == misc == "{{{

" some UI stuff need to be refreshed when $MYVIMRC is sourced
function! Me_RefreshUI()
    call webdevicons#refresh()
    AirlineRefresh
endfunction

" auto re-source init.vim
autocmd BufWritePost $MYVIMRC source $MYVIMRC | call Me_RefreshUI()

"}}}
