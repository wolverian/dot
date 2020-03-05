call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dag/vim-fish'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

call plug#end()

set hidden
set et sw=2 ts=2
