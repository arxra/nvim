if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'tpope/vim-dispatch' " Allow tests to run async in quickfix buffer
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-markdown'
Plug 'donRaphaco/neotex'
Plug 'tmsvg/pear-tree' 
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'janko/vim-test' " Test bindings

"----------------- Eye candy --------------
Plug 'chriskempson/base16-vim'
Plug 'Yggdroot/indentLine' "Looks good, mostly
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'                      " usefull for moving files.
Plug 'ryanoasis/vim-devicons'                   " Pretty icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Pretty colors for the icons

"----------------- Fuzzy finder--------------
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"----------------- VCS ----------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree' "Local 'git' for undo history

"----------------- Language packs -----------
Plug 'sheerun/vim-polyglot'                     " Multi language syntax and indendtation package.
Plug 'mxw/vim-prolog'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'sirosen/vim-rockstar'

"----------------- Python related --------------
Plug 'plytophogy/vim-virtualenv'
Plug 'PieterjanMontens/vim-pipenv'

"--- Auto complettion engines and plugs------
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'liuchengxu/vista.vim'                     " Shows the structure of the doc, uses coc as provider
Plug 'kkoomen/vim-doge'                         " DOcument GEneration

call plug#end()
"}}}

" === Persistent Undo and buffer changes  ============ {{{

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile
set autowrite

" ================ Indentation ====================== {{{
set relativenumber
set number
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set nofoldenable
set colorcolumn=120
set foldmethod=syntax
let g:indentLine_char = '│'

" ================ Autopairs===========================
" Default rules for matching:
let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ }
autocmd BufNewFile,BufRead *.tex  let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ '<*>': {'closer': '</*>'}
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
imap <Esc> <Plug>(PearTreeFinishExpansion)

" ================ Split ===========================
set splitbelow splitright


" ================ Keybinds ========================={{{
" Mouse has keys?
set mouse=a
" Leader stuff
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <leader><leader> <c-^>

" quicksave
nnoremap <c-s> :update<CR>
inoremap <c-s> <c-o>:update<CR>

" Orientation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"F keys Toggle key
map <silent><F2> :NERDTreeToggle<CR>
map <silent><F3> :Vista!!<CR>
map <silent><F4> :Helptags<CR>
map <F5> :UndotreeToggle<cr>

"keybind allows exiting IEx via Esc
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>tt :TestNearest<CR>" In a test file runs the test nearest to the cursor, otherwise runs the last nearest test
nnoremap <leader>tf :TestFile<CR>   " In a test file runs all tests in the current file, otherwise runs the last file tests.
nnoremap <leader>ts :TestSuite<CR>  " Runs the whole test suite 
nnoremap <leader>tl :TestLast<CR>   " Runs the last test
nnoremap <leader>tr :TestVisit<CR>  " Visits the test file from which you last run your tests

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>


" ================== Vista confs ======================= {{{
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1

let g:vista_executive_for = {
      \ 'javascript': 'coc',
      \ 'typescript': 'coc',
      \ 'javascript.jsx': 'coc',
      \ 'python': 'coc',
      \ 'c++': 'coc',
      \ 'rust': 'coc',
      \ 'vimwiki': 'ctags',
      \ }


" ================== Theme and Look ======================= {{{
" Colours and shit 
set t_Co=256
colorscheme base16-onedark
set termguicolors
set guicursor=i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150

hi SpellBad cterm=underline
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
set spelllang=sv,en
filetype plugin on
syntax on

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#enable_icon = 1

"Airline manual stuff
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#vista#enabled = 1

" Markdown should be able to look prettier
let g:markdown_fenced_languages = ['docker=Dockerfile', 'html', 'python', 'bash=sh', 'rust', 'javascript', 'js=javascript', 'css', 'cpp']


" ================== Linting ======================= {{{
let g:vimwiki_list = [{'path': '~/vimwiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0



" ================== Linting ======================= {{{
let g:rustfmt_command = "rustfmt"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

let g:vimtex_format_enabled = 1

nmap <leader>f <Plug>(coc-format):w<cr>:w<cr>


" ================ Syntax and intelisense ================== {{{
set hidden
set cmdheight=2
set updatetime=300
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = [
      \ 'coc-snippets', 
      \ 'coc-spell-checker', 
      \ 'coc-cspell-dicts',
      \ 'coc-vimtex', 
      \ 'coc-java', 
      \ 'coc-rls', 
      \ 'coc-python', 
      \ 'coc-svelte', 
      \ 'coc-json', 
      \ 'coc-yaml', 
      \ 'coc-tsserver', 
      \ 'coc-tslint-plugin', 
      \ 'coc-html', 
      \ 'coc-markdownlint']

inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Show all diagnostics
nnoremap <silent> <leader>v  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" navigate diagnostics
nmap <silent> <leader>h <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>l <Plug>(coc-diagnostic-next)


" Show codeactions
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" If the file is a tex file, set spell and leader hl to jump to spelling
" mistakes instead of through diagnostic errors
autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.tex set filetype=tex
autocmd BufNewFile,BufRead *.tex nmap <leader>l ]s
autocmd BufNewFile,BufRead *.tex nmap <leader>h [s 
autocmd BufNewFile,BufRead *!.tex nmap <silent> <leader>h <Plug>(coc-diagnostic-prev)
autocmd BufNewFile,BufRead *!.tex nmap <silent> <leader>l <Plug>(coc-diagnostic-next)

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Custom Commands
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" ============ Fuzzy searching ============ {{{
" <leader>s for Rg search
noremap <leader>s :Rooter<cr>:Rg<cr>
noremap <leader>b :Buffers<cr>
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:rooter_manual_only = 1

" This fancy boi opens a floating window for searching.
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, 'number',  'no')

  let height = float2nr(&lines/1.8)
  let width = float2nr(&columns - (&columns * 2 / 10))
  "let width = &columns
  let row = float2nr(&lines / 3)
  let col = float2nr((&columns - width) / 3)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height':height,
        \ }
  let win =  nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 1)
  call setwinvar(win, '&relativenumber', 0)
endfunction

if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif


command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%', '?'),
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

" Always show preview
let g:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

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

" === Testing configurations              ============ {{{
let test#strategy = {
      \ 'nearest': 'neovim',
      \ 'file':    'dispatch',
      \ 'suite':   'dispatch',
      \}
let test#python#runner = 'pytest'
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose' and Python's built-in 'unittest'

