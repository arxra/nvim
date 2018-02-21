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
Plug 'Valloric/YouCompleteMe'
Plug 'airodactyl/neovim-ranger'
Plug 'donRaphaco/neotex'
Plug 'neomake/neomake'
Plug 'dbgx/lldb.nvim'
Plug 'elixir-lang/vim-elixir'
Plug 'severin-lemaignan/vim-minimap'

call plug#end()
"}}}


"Highliting/scheme"
colorscheme NeoSolarized
set background=dark

let g:minimap_highlight='Visual'
