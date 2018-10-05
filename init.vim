if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'shime/vim-livedown'
Plug 'janko-m/vim-test'
Plug 'slashmili/alchemist.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'sickill/vim-monokai'
Plug 'brooth/far.vim'
"Plug 'airodactyl/neovim-ranger'
Plug 'scrooloose/nerdtree'
Plug 'donRaphaco/neotex'
Plug 'tpope/vim-dispatch'
Plug 'sbdchd/neoformat'
Plug 'dbgx/lldb.nvim' 
Plug 'tpope/vim-fugitive'

"--- Language packs ----
Plug 'rust-lang/rust.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'mxw/vim-prolog'

"--- Auto complettion engines and plugs---
Plug 'Valloric/YouCompleteMe'
"Plug 'ervandew/eclim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } "Live seach through code for completion
Plug 'itchyny/lightline.vim' "Statusline
Plug 'jiangmiao/auto-pairs'
Plug 'tweekmonster/django-plus.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()
"}}}


"Highliting/scheme"
colorscheme monokai
set background=dark
set termguicolors

let g:minimap_highlight='Visual'

" ================ Markdown ===========================
let g:livedown_port = 1337

" ================ Keybinds ========================={{{
let mapleader = " "

"Deoplete binds
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"NERDTREE Toggle key
map <silent> <F2> :NERDTreeToggle<CR>
"map <F3> <C-\><C-n>
tnoremap <Esc> <C-\><C-n> "keybind allows exiting IEx via Esc
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}
"
" ================== Theme ======================= {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"Eclim also wants in on that sweet omnifunc action
let g:EclimCompletionMethod = 'omnifunc'
:set spelllang=sv,en
:set spell
"}}}
"
" =================== YCM ======================= {{{
"let g:ycm_global_ycm_extra_conf = '$USER/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
set completeopt=longest,menuone

"}}}
" ================ Persistent Undo ================== {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" }}}
" ================ Indentation ====================== {{{

set number
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smartindent
set nofoldenable
set colorcolumn=120
set foldmethod=syntax

" }}}

