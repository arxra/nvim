if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'vim-pandoc/vim-pandoc'
Plug 'janko-m/vim-test'
Plug 'slashmili/alchemist.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'brooth/far.vim'
"Plug 'airodactyl/neovim-ranger'
Plug 'scrooloose/nerdtree'
Plug 'donRaphaco/neotex'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'dbgx/lldb.nvim' 
Plug 'elixir-lang/vim-elixir'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-scripts/vim-auto-save'
"--- Auto complettion engines and plugs---
Plug 'ervandew/eclim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } "Live seach through code for completion
Plug 'itchyny/lightline.vim' "Statusline
Plug 'jiangmiao/auto-pairs'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'tweekmonster/django-plus.vim'

call plug#end()
"}}}


"Highliting/scheme"
colorscheme NeoSolarized
set background=dark

let g:minimap_highlight='Visual'


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
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
let g:deoplete#enable_at_startup = 1
let g:deoplete#min_pattern_length = 0
let g:deoplete#enable_smart_case = 1

"Eclim also wants in on that sweet omnifunc action
let g:EclimCompletionMethod = 'omnifunc'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'
"}}}
"
" =================== YCM ======================= {{{
"let g:ycm_global_ycm_extra_conf = '/home/jarhb/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
"let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
"let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
"let g:ycm_complete_in_comments = 1 " Completion in comments
"let g:ycm_complete_in_strings = 1 " Completion in string

"}}}
" ================ Persistent Undo ================== {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" }}}
" ================ Indentation ====================== {{{

set number
set relativenumber
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set nofoldenable
set colorcolumn=120
set foldmethod=syntax

" }}}

