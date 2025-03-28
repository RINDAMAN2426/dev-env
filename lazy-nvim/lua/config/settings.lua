local set = vim.opt

-- auto reload
vim.o.autoread = true
vim.cmd([[autocmd FocusGained,BufEnter * checktime]])

-- general
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true
set.clipboard = "unnamedplus"
set.mouse = "a"

-- search
set.ignorecase = true
set.smartcase = true
set.incsearch = true

-- display
set.cursorline = true
set.signcolumn = "yes"
set.foldlevel = 99 -- 전체 폴드를 열어둔 상태
set.foldlevelstart = 99
set.termguicolors = true
-- set.background = 'light'

-- buffer
set.showtabline = 2
set.laststatus = 2
