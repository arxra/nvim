if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'janko-m/vim-test'
Plug 'slashmili/alchemist.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'brooth/far.vim'
Plug 'Valloric/YouCompleteMe'
"Plug 'airodactyl/neovim-ranger'
Plug 'scrooloose/nerdtree'
Plug 'donRaphaco/neotex'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'dbgx/lldb.nvim' 
Plug 'elixir-lang/vim-elixir'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-scripts/vim-auto-save'
"Plug 'ervandew/eclim'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } "Live seach through code for completion
Plug 'itchyny/lightline.vim' "Statusline

call plug#end()
"}}}


"Paths"
"let g:python3_host_prog = expand('~/.config/nvim/env/bin/python')
"let g:python2_host_prog = '/usr/bin/python2.7'

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
"let g:deoplete#enable_at_startup = 1
let g:ycm_global_ycm_extra_conf = '/home/jarhb/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"}}}
" ================ Persistent Undo ================== {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" }}}
" ================ Indentation ====================== {{{

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set nofoldenable
set colorcolumn=80
set foldmethod=syntax

" }}}

