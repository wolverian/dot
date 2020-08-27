" neovim configuration

" vi:foldmethod=marker

set shell=/bin/zsh
let $SHELL = '/bin/zsh'

" Leader {{{

let mapleader = " "
let maplocalleader = ";"

" }}}

" Plugins {{{

call plug#begin('~/.vim/plugged')

" Language Server support {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
      \ 'coc-marketplace',
      \ 'coc-rls',
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
" Plug 'edwinb/idris2-vim'
Plug 'idris-hackers/idris-vim'
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

" }}}

" Miscellaneous {{{

" TODO: Do we need this?
" Plug 'vim-syntastic/syntastic'

" TODO: platform differences
" Plug '/usr/share/doc/fzf/examples'
Plug '/usr/local/opt/fzf'

Plug 'junegunn/fzf.vim'
Plug 'blerins/flattown'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'dhruvasagar/vim-zoom'

" }}}

call plug#end()

" }}}

" Basic Configuration {{{

set bg=light
colorscheme minimal
" set bg=dark
" colorscheme gruvbox

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

" Fuzzy finding {{{

nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]f     :<C-u>FZF<CR>
nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

" }}}

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

" rust-analyzer crashes
" autocmd FileType rust nmap <leader>R :CocCommand rust-analyzer.run<cr>

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
autocmd FileType rust set foldmethod=syntax

" }}}

" }}}
