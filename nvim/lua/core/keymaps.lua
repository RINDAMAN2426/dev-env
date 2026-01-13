-- Save file
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", {
  desc = "Save file",
})

-- Close buffer
vim.keymap.set("n", "<leader>x", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", {
  desc = "Close Current Buffer"
})

-- ============================================================================
-- Telescope
-- ============================================================================

vim.keymap.set("n", "<leader>p", "<cmd>Telescope git_files<cr>", {
  desc = "Git Files"
})

vim.keymap.set("n", "<leader>fp", "<cmd>Telescope find_files<cr>", {
  desc = "Find Files"
})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>", {
  desc = "Live Grep"
})

vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {
  desc = "Buffers"
})

vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
  desc = "LSP References"
})

vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {
  desc = "LSP Implementations"
})

vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {
  desc = "LSP Definitions"
})

-- ============================================================================
-- Neo-tree
-- ============================================================================

vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle<cr>", {
  desc = "Toggle Explorer"
})

-- ============================================================================
-- Bufferline
-- ============================================================================

vim.keymap.set("n", "<leader>]", "<cmd>BufferLineCycleNext<cr>", {
  desc = "Next Buffer"
})

vim.keymap.set("n", "<leader>[", "<cmd>BufferLineCyclePrev<cr>", {
  desc = "Prev Buffer"
})

-- ============================================================================
-- Trouble
-- ============================================================================

vim.keymap.set("n", "<leader>dx", "<cmd>Trouble diagnostics toggle<cr>", {
  desc = "Diagnostics (Trouble)"
})

vim.keymap.set("n", "<leader>dw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {
  desc = "Diagnostics (Buffer)"
})

vim.keymap.set("n", "<leader>dl", "<cmd>Trouble loclist toggle<cr>", {
  desc = "Location List"
})

vim.keymap.set("n", "<leader>dq", "<cmd>Trouble qflist toggle<cr>", {
  desc = "Quickfix List"
})

-- ============================================================================
-- Neotest
-- ============================================================================

vim.keymap.set("n", "<leader>tt", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, {
  desc = "Test File"
})

vim.keymap.set("n", "<leader>tT", function()
  require("neotest").run.run(vim.uv.cwd())
end, {
  desc = "Test All Files"
})

vim.keymap.set("n", "<leader>tr", function()
  require("neotest").run.run()
end, {
  desc = "Test Nearest"
})

vim.keymap.set("n", "<leader>tl", function()
  require("neotest").run.run_last()
end, {
  desc = "Test Last"
})

vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, {
  desc = "Test Summary"
})

vim.keymap.set("n", "<leader>to", function()
  require("neotest").output.open({ enter = true, auto_close = true })
end, {
  desc = "Test Output"
})

vim.keymap.set("n", "<leader>tO", function()
  require("neotest").output_panel.toggle()
end, {
  desc = "Test Output Panel"
})

vim.keymap.set("n", "<leader>tS", function()
  require("neotest").run.stop()
end, {
  desc = "Test Stop"
})

vim.keymap.set("n", "<leader>tw", function()
  require("neotest").watch.toggle(vim.fn.expand("%"))
end, {
  desc = "Test Watch"
})

vim.keymap.set("n", "<leader>td", function()
  require("neotest").run.run({ strategy = "dap" })
end, {
  desc = "Debug Nearest Test"
})

-- Reload neotest (useful after :cd in monorepo)
vim.keymap.set("n", "<leader>tc", function()
  local cwd = vim.fn.getcwd()
  -- Clear neotest state and reload
  local neotest = require("neotest")
  neotest.state.stop()
  -- Brief delay to ensure state is cleared
  vim.defer_fn(function()
    print("Neotest reloaded. Root: " .. cwd)
    -- Reopen summary if it was open
    if vim.fn.bufwinnr("Neotest Summary") ~= -1 then
      neotest.summary.close()
      neotest.summary.open()
    end
  end, 100)
end, {
  desc = "Reload Neotest for CWD"
})

-- ============================================================================
-- LSP & Diagnostics
-- ============================================================================

-- Diagnostics navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
  desc = "Previous Diagnostic"
})

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
  desc = "Next Diagnostic"
})

vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
  desc = "Show Diagnostic"
})

-- LSP keymaps (attached when LSP is available)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local opts = { buffer = args.buf }
    
    -- Navigation
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, {
      desc = "Go to Declaration"
    }))
    
    -- Hover
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
      desc = "Hover Documentation"
    }))
    
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, {
      desc = "Signature Help"
    }))
    
    -- Code Actions
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
      desc = "Code Action"
    }))
    
    -- Refactoring
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
      desc = "Rename Symbol"
    }))
    
    -- Formatting
    vim.keymap.set("n", "<leader>fm", function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, {
      desc = "Format Buffer"
    }))
  end,
})
