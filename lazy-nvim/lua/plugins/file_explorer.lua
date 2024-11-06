return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          highlight_opened_files = "name",
          icons = {
            show = {
              file = true,
              folder = true,
              git = true,
            },
          },
        },
        git = {
          enable = true,
          ignore = false,
        },
        filters = {
          dotfiles = false,
        },
      })
      vim.api.nvim_set_keymap("n", "<C-p>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },
}

