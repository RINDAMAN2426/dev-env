
set clipboard+=unnamedplus
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers
set autoindent " Indent a new line
set inccommand=split " Show replacements in a split screen
set mouse=a " Allow to use the mouse in the editor
set relativenumber " Shows the line numbers
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set wildmenu " Show a more advance menu
"set cc=80 " Show at 80 column a border for good code style
filetype plugin indent on   " Allow auto-indenting depending on file type
syntax on
highlight LineNr guifg=white
set spell " enable spell check (may need to download language package)
set ttyfast " Speed up scrolling in Vim
set omnifunc=syntaxcomplete#Complete "omni auto suggestion

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

  Plug 'rebelot/kanagawa.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-fugitive'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'romgrk/barbar.nvim'

  " fzf.vim: Fuzzy Finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " wildemenu plugin - wilder
  if has('nvim')
    function! UpdateRemotePlugins(...)
      " Needed to refresh runtime files
      let &rtp=&rtp
      UpdateRemotePlugins
    endfunction

    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
  else
    Plug 'gelguy/wilder.nvim'

    " To use Python remote plugin features in Vim, can be skipped
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'

  endif

call plug#end()

colorscheme kanagawa
" airline configs
let g:bargreybars_auto=0
let g:airline_solorized_bg='dark'
let g:airline_powerline_fonts=1
let g:airline#extension#tabline#enable=0
let g:airline#extension#tabline#left_sep=' '
let g:airline#extension#tabline#left_alt_sep='|'
let g:airline#extension#tabline#formatter='unique_tail'

" coc configs
let g:coc_global_extensions = ['coc-highlight', 'coc-prettier']
call extend(g:coc_global_extensions, ['coc-tsserver', 'coc-eslint'])
call extend(g:coc_global_extensions, ['coc-css', 'coc-html', 'coc-styled-components'])
call extend(g:coc_global_extensions, ['coc-json', 'coc-yaml'])
call extend(g:coc_global_extensions, ['coc-biome'])

" wilder 
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })
" 'border'            : 'single', 'double', 'rounded' or 'solid'
"                     : can also be a list of 8 characters,
"                     : see :h wilder#popupmenu_border_theme() for more details
" 'highlights.border' : highlight to use for the border`
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlights': {
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
      \ })))

" maps
nnoremap <C-f> :RG<CR>
vnoremap <C-n> :norm  

nnoremap <leader>x "_x
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>ccs <Plug>(coc-codeaction-selected)w
nmap <silent> gl :CocDiagnostics<CR>
nmap <leader>caf :CocCommand eslint.executeAutofix<CR>
nmap <leader>cff :CocCommand prettier.formatFile<CR>

" tabs
nmap <leader>] <Cmd>BufferNext<CR>
nmap <leader>[ <Cmd>BufferPrevious<CR>
nmap <leader>p <Cmd>BufferPick<CR>
nmap <leader>bc <Cmd>BufferClose<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call CocAction('doHover')<CR>
nmap <space>rn <Plug>(coc-rename)

" >> Tab to Autocomplete
inoremap <silent><expr> <TAB>
  \ coc#pum#visible()
    \ ? coc#pum#next(1)
    \ : CheckBackspace()
      \ ? "\<Tab>"
      \ : coc#refresh()

inoremap <silent><expr> <S-TAB>
  \ coc#pum#visible()
    \ ? coc#pum#prev(1)
    \ : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" reload
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<CR>
" trigger suggestion
inoremap <silent><expr> <C-g> coc#refresh()

nnoremap<C-S> :w<CR>
nnoremap<C-O> :Lexplore<CR>

nnoremap<C-P> :Files<CR>
highlight LineNr guifg=#eed3d9

" lua
lua << EOF
  require'bufferline'.setup()
EOF
