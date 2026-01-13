return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Install parsers on first load
      local parsers = {
        "lua", "vim", "vimdoc", "bash", "diff",
        "javascript", "typescript", "tsx",
        "python", "regex", "json", "jsonc",
        "css", "html", "terraform", "hcl",
        "dockerfile", "yaml", "xml", "toml",
        "graphql", "sql", "query",
        "markdown", "markdown_inline",
      }
      
      -- Install parsers (async, no-op if already installed)
      require("nvim-treesitter").install(parsers)
      
      -- Enable treesitter highlighting for all supported filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua", "vim", "bash",
          "javascript", "typescript", "typescriptreact",
          "python", "json", "jsonc", "css", "html",
          "terraform", "hcl", "dockerfile",
          "yaml", "xml", "toml", "graphql", "sql",
          "markdown",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
  },
}

