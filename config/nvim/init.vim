call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dag/vim-fish'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'sdiehl/vim-ormolu'
Plug 'morhetz/gruvbox'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

set hidden
set et sw=2 ts=2
set cmdheight=2
set updatetime=300
set shortmess+=c

colorscheme gruvbox

nnoremap <silent> K :call <SID>show_documentation()<CR>
