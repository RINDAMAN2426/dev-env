return {
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- load colorscheme
      vim.cmd([[colorscheme nord]])
    end
  }
}

