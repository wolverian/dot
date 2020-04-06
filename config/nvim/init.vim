call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dag/vim-fish'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Haskell

Plug 'sdiehl/vim-ormolu'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

" Colorschemes

Plug 'morhetz/gruvbox'

call plug#end()

set hidden
set et sw=2 ts=2
set cmdheight=2
set updatetime=300
set shortmess+=c

autocmd User CocJumpPlaceholder call
      \ CocActionAsync('showSignatureHelp')

" Mappings

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let mapleader = ","

nmap <leader>f :GFiles<CR>
nmap <leader><leader> :b#<cr>
nmap <leader>v <c-w>v<c-w>l:b#<cr>
nmap <leader>t :terminal<cr>
