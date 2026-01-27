local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.cursorline = true

opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.hidden = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 1
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.timeout = true
opt.timeoutlen = 300
opt.ttimeout = true
opt.ttimeoutlen = 10

opt.updatetime = 100
opt.lazyredraw= true

opt.virtualedit = "block"

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99        -- 기본은 전부 펼쳐진 상태
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

