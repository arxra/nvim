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
Plug 'tpope/vim-surround'

"----------------- Fuzzy finder--------------
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"----------------- VCS ----------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree' "Local 'git' for undo history

"----------------- Language packs -----------
Plug 'mxw/vim-prolog'
Plug 'cespare/vim-toml'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-latex/vim-latex'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'

"--- Auto complettion engines and plugs------
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

" ================ Split ===========================
set splitbelow splitright


" ================ Keybinds ========================={{{
" Leader stuff
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap ; :
nnoremap <leader><leader> <c-^>
nnoremap <Leader>w :w<CR>


" Orientation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


"F keys Toggle key
map <silent> <F2> :NERDTreeToggle<CR>
map <silent><F3> :make!<CR>
map <silent><F4> :make! demo<CR>
map <F5> :UndotreeToggle<cr>
"map <F3> <C-\><C-n>
tnoremap <Esc> <C-\><C-n> "keybind allows exiting IEx via Esc
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" ================== Theme and Look ======================= {{{
" Colours
colorscheme srcery
set background=dark
set termguicolors

hi SpellBad cterm=underline
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
set spelllang=sv,en
filetype plugin on


"Airline manual stuff
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
"Autosave? maybe? 
autocmd TextChanged,TextChangedI <buffer> silent write
"C++ specific highliting 
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

"}}}
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

" navigate diagnostics
nmap <silent> <leader>h <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>l <Plug>(coc-diagnostic-next)
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
" === Fuzzy searching ============ {{{
" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }

" 
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif


command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,
         \intermediate/*,*.o,*.hi,Zend,vendor
         \*.pys


" === Persistent Undo and buffer changes ============ {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile
set autowrite

" ================ Indentation ====================== {{{
set relativenumber
set number
set shiftwidth=3
set softtabstop=3
set tabstop=3
set expandtab
set smartindent
set nofoldenable
set colorcolumn=120
set foldmethod=syntax
let g:indentLine_char = '│'
