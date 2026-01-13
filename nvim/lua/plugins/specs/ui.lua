return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filename", path = 1 },
          {
            function()
              local neotest = package.loaded["neotest"]
              if not neotest then
                return ""
              end
              local adapters = neotest.state.adapter_ids()
              if vim.tbl_isempty(adapters) then
                return ""
              end
              local status_counts = {}
              for _, adapter_id in ipairs(adapters) do
                for _, count in pairs(neotest.state.status_counts(adapter_id)) do
                  for status, value in pairs(count) do
                    status_counts[status] = (status_counts[status] or 0) + value
                  end
                end
              end
              local result = {}
              if status_counts.running then
                table.insert(result, "●" .. status_counts.running)
              end
              if status_counts.passed then
                table.insert(result, "✓" .. status_counts.passed)
              end
              if status_counts.failed then
                table.insert(result, "✖" .. status_counts.failed)
              end
              if status_counts.skipped then
                table.insert(result, "○" .. status_counts.skipped)
              end
              if vim.tbl_isempty(result) then
                return ""
              end
              return table.concat(result, " ")
            end,
            cond = function()
              return package.loaded["neotest"] ~= nil
            end,
            color = { fg = "#98c379" },
          },
        },
        lualine_x = {
          "diagnostics",
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      highlight = true,
      sperator = " › ",
      depth_limit = 5,
      depth_limit_indicator = "..",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = {
        char = "|",
      },
      scope = {
        enabled = true,
      },
    },
  },
  {
    { "HiPhish/rainbow-delimiters.nvim" },
  },
}
