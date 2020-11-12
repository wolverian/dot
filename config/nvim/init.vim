" neovim configuration

" vi:foldmethod=marker

" Leader {{{

let mapleader = " "
let maplocalleader = ";"

" }}}

" Plugins {{{

" Install vim-plug {{{

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

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
      \ 'coc-json',
      \ 'coc-fzf-preview',
      \ ]

" }}}

" Language support {{{

Plug 'dag/vim-fish'
Plug 'derekelkins/agda-vim'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'

" Rust {{{

Plug 'mhinz/vim-crates'

" }}}

" Haskell {{{

" TODO: Use haskell-ide-engine instead: <https://github.com/haskell/haskell-language-server>
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'sdiehl/vim-ormolu'

" }}}

" }}}

" Colorschemes {{{

Plug 'wolverian/minimal'
Plug 'morhetz/gruvbox'
Plug 'yorickpeterse/vim-paper'
Plug 'Canop/patine'
Plug 'seesleestak/duo-mini'
Plug 'fxn/vim-monochrome'
Plug 'Lokaltog/vim-monotone'
Plug '~/src/text'

" }}}

" Miscellaneous {{{

" TODO: platform differences
Plug '/usr/share/doc/fzf/examples'
" Plug '/usr/local/opt/fzf'

Plug 'junegunn/fzf.vim'
Plug 'blerins/flattown'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'dhruvasagar/vim-zoom'
Plug 'liuchengxu/vim-clap'
Plug 'vn-ki/coc-clap'

" }}}

call plug#end()

" }}}

" Basic Configuration {{{

" Enable true color inside screen/tmux only, because blink.sh doesn't render
" it correctly otherwise.
function! s:dark()
  set bg=dark
  if $TERM =~ "^screen"
    set termguicolors
    let g:monotone_emphasize_comments=1
    colorscheme monotone
  else
    set notermguicolors
    colorscheme flattown
  endif
endfunction

function! s:light()
  set bg=light
  if $TERM =~ "^screen"
    set termguicolors
    colorscheme paper
  else
    set notermguicolors
    colorscheme minimal
  endif
endfunction

call s:dark()

nnoremap <leader>tl :call <SID>light()<cr>
nnoremap <leader>td :call <SID>dark()<cr>

" set bg=light
" colorscheme minimal

set hidden
set et sw=2 ts=2
set cmdheight=2
set updatetime=300
set shortmess+=c
set laststatus=2
set statusline=%f
set fillchars+=fold:\ 

" }}}

" Common shortcuts {{{

nmap <cr> :Clap files<cr>
nmap <bs> :Clap coc_symbols<cr>

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

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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

" Refactoring {{{

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

" rust-analyzer crashes
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

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

autocmd BufWritePre,FileWritePre *.rs Format

" }}}

" }}}
