call plug#begin()

"" PluginList
"" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"" leap
Plug 'ggandor/leap.nvim'
"" LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release'}
"" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"" air-line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"" tab
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
"" config
set number
set encoding=utf8
set autoindent
set smartindent
set guicursor+=n:underline
set expandtab
set et
"" commands
command -nargs=0 CPP "let @* = expand('%')"

"" > mapping
"" save
nnoremap <C-s> :w<cr>
"" fuzzy
nnoremap <C-P> :Files<CR>
"" netwr
nnoremap <C-o> :Explorer<CR>
"" leap
nmap <leader>f <Plug>(leap-forward)
nmap <leader>F <Plug>(leap-backward)
"" coc
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"
" File: netrw-sidebar.vim
" Author: Jeffrey Hill <jeff@reverentengineer.com>
"
" Description: Creates a netrw sidebar
"

if exists('g:netrw_sidebar_loaded')
  finish
endif
let g:netrw_sidebar_loaded = 1

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <leader>e :call ToggleVExplorer()<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" buffer
nmap <leader>] <Cmd>BufferNext<CR>
nmap <leader>[ <Cmd>BufferPrevious<CR>
nnoremap <leader>1 <Cmd>BufferGoto 1<CR>
nnoremap <leader>2 <Cmd>BufferGoto 2<CR>
nnoremap <silent><M-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent><M-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent><M-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent><M-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent><M-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent><M-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent><M-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent><M-0> <Cmd>BufferLast<CR>
nmap <leader>w <Cmd>BufferClose<CR>

"" lua
lua << EOF
        
EOF
