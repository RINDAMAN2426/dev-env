local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- save
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<ESC>:w<CR>a", opts)
map("v", "<C-s>", "<ESC>:w<CR>gv", opts)

