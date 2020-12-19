set nocompatible "It's like a shebang of the vim 21st century - anon

" == Plugins {{{
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim
   \ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.local/share/nvim/plugged')

" utilities and themes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'ghifarit53/tokyonight-vim'

" languages and stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'sheerun/vim-polyglot'

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

" == netrw == {{{

set autochdir

let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize=-28
let g:netrw_banner=0

function! Me_netrwToggle()
  let instance = bufnr("$")
  let netrwBuffed = 0
  while (instance >= 1)
    if (getbufvar(instance, "&filetype") == "netrw")
      silent exe "bwipeout " . instance
      let netrwBuffed = 1
    endif
    let instance-=1
  endwhile
  if !netrwBuffed
    silent Lexplore
  endif
endfunction

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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Format On Save
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"}}}

" == custom key == "{{{

" open terminal
nnoremap <silent> <leader><Enter> :rightbelow 5sp new<CR>:terminal<CR>
" open netrw
nnoremap <silent> <leader>f :call Me_netrwToggle()<CR>
" reload config
nnoremap <silent> <leader>sv :source $MYVIMRC <bar> :AirlineRefresh<CR>
" unhighlight
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR>
" open fzf
nnoremap <silent> <leader><leader> :Files<CR>
" flutter
nnoremap <silent> <F4> :CocCommand flutter.emulators<CR>
nnoremap <silent> <F5> :CocCommand flutter.dev.openDevLog <bar> flutter.run<CR>

"}}}
