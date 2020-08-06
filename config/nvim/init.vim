" neovim configuration

" vi:foldmethod=marker

" Leader {{{

let mapleader = ","
let localmapleader = ";"

" }}}

" Plugins {{{

call plug#begin('~/.vim/plugged')

" Language Server support {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
      \ 'coc-marketplace',
      \ 'coc-rust-analyzer',
      \ 'coc-actions',
      \ 'coc-tsserver',
      \ 'coc-fish',
      \ 'coc-yaml',
      \ ]

" }}}

" Language support {{{

Plug 'dag/vim-fish'
" Plug 'edwinb/idris2-vim'
Plug 'idris-hackers/idris-vim'
Plug 'derekelkins/agda-vim'

" Haskell {{{

" TODO: Use haskell-ide-engine instead: <https://github.com/haskell/haskell-language-server>
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

Plug 'sdiehl/vim-ormolu'

" }}}

" }}}

" Colorschemes {{{

Plug 'wolverian/minimal'
Plug 'morhetz/gruvbox'

" }}}

" Miscellaneous {{{

" TODO: Do we need this?
Plug 'vim-syntastic/syntastic'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'blerins/flattown'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'

" }}}

call plug#end()

" }}}

" Basic Configuration {{{

colorscheme minimal

set hidden
set et sw=2 ts=2
set cmdheight=2
set updatetime=300
set shortmess+=c
set laststatus=0

" }}}

" Common shortcuts {{{

nmap <leader>f :GFiles<CR>
nmap <leader><leader> :b#<cr>
nmap <leader>v <c-w>v<c-w>l:b#<cr>
nmap <leader>t :terminal<cr>

" }}}

" coc.vim Configuration {{{

" Mappings {{{

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" }}}

" Diagnostics {{{

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" }}}

" Code Navigation {{{

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"}}}

" Symbol Renaming {{{

nmap <leader>rn <Plug>(coc-rename)

"}}}

" Actions {{{

" Example: `<leader>aap` for current paragraph

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Current buffer
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Run things

autocmd FileType rust nmap <leader>R :CocCommand rust-analyzer.run<cr>

" }}}

" Selections {{{

" coc.vim Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" }}}

" Miscellaneous {{{

autocmd User CocJumpPlaceholder call
      \ CocActionAsync('showSignatureHelp')

autocmd BufWritePre,FileWritePre *.rs Format

" }}}

" }}}
