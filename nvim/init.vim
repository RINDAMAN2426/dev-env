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

