set nocompatible "It's like a shebang of the vim 21st century - anon

let is_win = has("win64") || has("win32") || has("win16")

" == Plugins {{{
if !is_win
  if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim
    \ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
  endif
endif

call plug#begin('~/.local/share/nvim/plugged')

" utilities and themes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'ghifarit53/tokyonight-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" languages and stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'

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
set undodir=/tmp
set undofile
set visualbell

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

" == custom command == "{{{

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" flutter
command! -nargs=0 Flutemu :CocCommand flutter.emulators
command! -nargs=0 Flutlog :CocCommand flutter.dev.openDevLog
command! -nargs=0 Flutrun :CocCommand flutter.run

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
if !is_win
  let g:NERDTreeBookmarksFile = "$HOME/.config/nvim/NERDTreeBookmarks"
else
  let g:NERDTreeBookmarksFile = "%LOCALAPPDATA%/nvim/NERDTreeBookmarks"
endif
let g:NERDTreeWinSize = 28
let g:NERDTreeChDirMode = 2
let g:NERDTreeDirArrowExpandable=""
let g:NERDTreeDirArrowCollapsible=""

"}}}

" == coc setup == "{{{

let g:coc_global_extensions = [
            \'coc-css',
            \'coc-flutter',
            \'coc-git',
            \'coc-html',
            \'coc-json',
            \'coc-lists',
            \'coc-marketplace',
            \'coc-pairs',
            \'coc-snippets',
            \'coc-prettier',
            \'coc-python',
            \'coc-tsserver',
            \'coc-xml',
            \'coc-yaml',
            \'coc-vimlsp',
            \'coc-toml',
            \]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
  highlight signcolumn guibg=NONE
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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
