if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/plugged')

Plug 'slashmili/alchemist.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'brooth/far.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'airodactyl/neovim-ranger'
Plug 'scrooloose/nerdtree'
Plug 'donRaphaco/neotex'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'dbgx/lldb.nvim' 
Plug 'elixir-lang/vim-elixir'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-scripts/vim-auto-save'
Plug 'ervandew/eclim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


call plug#end()
"}}}


"Paths"
"let g:python3_host_prog = expand('~/.config/nvim/env/bin/python')
"let g:python2_host_prog = '/usr/bin/python2.7'

"Highliting/scheme"
colorscheme NeoSolarized
set background=dark

let g:minimap_highlight='Visual'
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
" ================ Statusline ======================== {{{

hi User1 guifg=#FF0000 guibg=#425762 gui=bold
hi User2 guifg=#FFFFFF guibg=#FF1111 gui=bold
set statusline=\ %{toupper(mode())}                                             "Mode
"set statusline+=\ \│\ %{fugitive#head()}                                        "Git branch
set statusline+=\ \│\ %4F                                                       "File path
set statusline+=\ %1*%m%*                                                       "Modified indicator
set statusline+=\ %w                                                            "Preview indicator
set statusline+=\ %r                                                            "Read only indicator
set statusline+=\ %q                                                            "Quickfix list indicator
set statusline+=\ %=                                                            "Start right side layout
set statusline+=\ %{&enc}                                                       "Encoding
set statusline+=\ \│\ %y                                                        "Filetype
set statusline+=\ \│\ %p%%                                                      "Percentage
set statusline+=\ \│\ %c                                                        "Column number
set statusline+=\ \│\ %l/%L                                                     "Current line number/Total line numbers
"set statusline+=\ %{gutentags#statusline('\│\ ')}                               "Tags status
"set statusline+=\ %2*%{ALEGetStatusLine()}%*                                    "Errors count

"}}}

