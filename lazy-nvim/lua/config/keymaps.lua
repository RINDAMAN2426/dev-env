local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- set leader key to space in lazy.lua

-- save
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<ESC>:w<CR>a", opts)
map("v", "<C-s>", "<ESC>:w<CR>gv", opts)

-- nvimtree
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

-- bufferline
for i = 1, 9 do
  map("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
end
map("n", "<leader>p", ":BufferLineCyclePrev<CR>", opts)
map("n", "<leader>n", ":BufferLineCycleNext<CR>", opts)
map("n", "<leader>bc", ":BufferLineCloseOthers<CR>", opts)

-- bbye
map("n", "<leader>q", ":Bdelete<CR>", opts)

-- fzf
map("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", opts)
map("n", "<C-f>", "<cmd>lua require('fzf-lua').live_grep()<CR>", opts)

-- lsp
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", opts)
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts)
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", opts)

