if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'shime/vim-livedown'
Plug 'janko-m/vim-test'
Plug 'slashmili/alchemist.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'kmszk/skyhawk'
Plug 'morhetz/gruvbox'
Plug 'srcery-colors/srcery-vim'
Plug 'brooth/far.vim'
"Plug 'airodactyl/neovim-ranger'
Plug 'scrooloose/nerdtree'
Plug 'donRaphaco/neotex'
Plug 'tpope/vim-dispatch'
Plug 'sbdchd/neoformat'
"Plug 'dbgx/lldb.nvim' 

"--- git --- 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"--- Language packs ----
"Plug 'rust-lang/rust.vim'
"Plug 'elixir-lang/vim-elixir'
"Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'mxw/vim-prolog'

"--- Auto complettion engines and plugs---
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'itchyny/lightline.vim' "Statusline
Plug 'jiangmiao/auto-pairs'
"Plug 'tweekmonster/django-plus.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()
"}}}


"Highliting/scheme"
colorscheme srcery
set background=dark
set termguicolors
hi clear SpellBad
hi SpellBad cterm=underline

let g:minimap_highlight='Visual'

" ================ Markdown ===========================
let g:livedown_port = 1337


" ================ Split ===========================
set splitbelow splitright


" ================ Keybinds ========================={{{
let mapleader = " "

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
            \ 'colorscheme': 'srcery',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus','gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'cocstatus': 'coc#status'}
            \ }

:set spelllang=sv,en
:set spell
"Autosave? yes please!
autocmd TextChanged,TextChangedI <buffer> silent write
"}}}
"
" ================ Concour of Code ================== {{{
set hidden
set cmdheight=2
set updatetime=300
set signcolumn=yes
inoremap <silent><expr> <c-space> coc#refresh()
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

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
let g:indentLine_char = '│'

" }}}
