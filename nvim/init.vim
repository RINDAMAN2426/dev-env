call plug#begin()

"" PluginList
"" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"" leap
Plug 'ggandor/leap.nvim'

"" config
set number
set smartcase

"" > mapping
"" fuzzy
nnoremap <C-P> :Files<CR>
"" netwr
nnoremap <C-o> :Explorer<CR>
"" leap
nmap <leader>f <Plug>(leap-forward)
nmap <leader>F <Plug>(leap-backward)

call plug#end()
