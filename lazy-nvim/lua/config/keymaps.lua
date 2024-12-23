local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- use blackhole register
map("n", "x", '"_d', opts);
map("n", "d", '"_d', opts);
map("n", "D", '"_d', opts);
map("v", "d", '"_d', opts);

-- unuse blackhole register
map("n", "<leader>d", '""d', opts);
map("n", "<leader>D", '""D', opts);
map("v", "<leader>d", '""d', opts);

-- save
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<ESC>:w<CR>a", opts)
map("v", "<C-s>", "<ESC>:w<CR>gv", opts)

-- nvimtree
map("n", "<C-o>", ":NvimTreeFindFileToggle<CR>", opts)

-- bufferline
for i = 1, 9 do
  map("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
end
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
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
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "qf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", opts)
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts)
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", opts)

-- comment
-- gcc: line comment
-- gbc: block comment
-- v mode + gc : line comment
-- v mode + gb : block comment

-- which-key
map("n", "<leader>?", "<cmd>lua require('which-key').show({global=false})<CR>", opts)

-- mason
map("n", "<leader>cm", "<cmd>:Mason<CR>", opts)

-- gitlinker
map("n", "<leader>gl", "<cmd>lua require('gitlinker').get_buf_range_url('n', { action_callback = require('gitlinker.actions').open_in_browser })<CR>", opts)

