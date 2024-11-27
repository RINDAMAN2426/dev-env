return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme onedark")
    end
  }
  --{
  --  "rebelot/kanagawa.nvim",
  --  dependencies = { "akinsho/bufferline.nvim" },
  --  lazy = false,
  --  priority = 1000,
  --  config = function()
  --    require("bufferline").setup({
  --      options = {
  --        separator_style = 'slant',
  --      },
  --    })
  --    vim.cmd("colorscheme kanagawa-dragon")
  --  end
  --}
  -- {
  --   "shaunsingh/nord.nvim",
  --   dependencies = { "akinsho/bufferline.nvim" },
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local colors = require("nord.colors")
  --     local highlights = require("nord").bufferline.highlights({
  --       fill = colors.nord0_gui,
  --       indicator = colors.nord9_gui,
  --       bg = colors.nord0_gui,
  --       buffer_bg = colors.nord0_gui,
  --       buffer_bg_selected = colors.nord1_gui,
  --       buffer_bg_visible = "#2A2F3A",
  --       bold = true,
  --       italic = false,
  --     })

  --     require("bufferline").setup({
  --       options = {
  --         separator_style = 'slant',
  --       },
  --       highlights = highlights,
  --     })
  --     -- load colorscheme
  --     vim.cmd([[colorscheme nord]])
  --   end
  -- },
  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   dependencies = "rktjmp/lush.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme('seoulbones')
  --   end
  -- }
}

