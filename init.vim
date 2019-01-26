if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'janko-m/vim-test'
Plug 'slashmili/alchemist.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'scrooloose/nerdtree'
Plug 'donRaphaco/neotex'
Plug 'sbdchd/neoformat'
Plug 'tmsvg/pear-tree' 
"
"---- Denite, the unifier of all -------
Plug 'Shougo/denite.nvim'

"--- git --- 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree' "Local git for undo history

"--- Language packs ----
Plug 'mxw/vim-prolog'

"--- Auto complettion engines and plugs---
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'vim-airline/vim-airline'

call plug#end()
"}}}



" ================ Autopairs===========================
" Default rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'}
            \ }
" See pear-tree/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default
let g:pear_tree_ft_disabled = []

" Pair expansion is dot-repeatable by default
let g:pear_tree_repeatable_expand = 1

" Smart pairs are disabled by default
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

imap <BS> <Plug>(PearTreeBackspace)
imap <CR> <Plug>(PearTreeExpand)
imap <Esc> <Plug>(PearTreeFinishExpansion)
" ================ Markdown ===========================
let g:livedown_port = 1337


" ================ Split ===========================
set splitbelow splitright


" ================ Keybinds ========================={{{
nnoremap <SPACE> <Nop>
let mapleader=" "

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <silent> <leader>q  :<C-u>Denite grep<cr><cr>
nnoremap <silent> <leader>e  :<C-u>Denite buffer<cr>
nnoremap <silent> <leader>o  :<C-u>Denite coc-symbols<cr>
nnoremap <silent> <leader>d  :<C-u>Denite coc-diagnostic<cr>
nnoremap <silent> <leader>c  :<C-u>Denite coc-command<cr>
nnoremap <silent> <leader>s  :<C-u>Denite coc-service<cr>
nnoremap <silent> <leader>l  :<C-u>Denite coc-link<cr>

"NERDTREE Toggle key
map <silent> <F2> :NERDTreeToggle<CR>
nnoremap <F5> :UndotreeToggle<cr>
"map <F3> <C-\><C-n>
tnoremap <Esc> <C-\><C-n> "keybind allows exiting IEx via Esc
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

call denite#custom#map(
      \ 'insert','<C-j>','<denite:move_to_next_line>','noremap')

call denite#custom#map(
      \ 'insert','<C-k>','<denite:move_to_previous_line>','noremap')


" ================== Theme and Look ======================= {{{
" Colours
colorscheme srcery
set background=dark
set termguicolors

hi SpellBad cterm=underline
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
set spelllang=sv,en

"Airline manual stuff
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
"Autosave? yes please!
"autocmd TextChanged,TextChangedI <buffer> silent write
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
