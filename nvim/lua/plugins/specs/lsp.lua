return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- core
        "lua_ls",

        -- develop
        "html",
        "cssls",
        "jsonls",
        "yamlls",
        "graphql",
        "ts_ls",
        "biome",

        -- devops
        "terraformls",
        "dockerls",
        "taplo", -- toml
        "lemminx", -- xml

        -- scripts
        "bashls",
        "pyright",
        "sqlls",

        -- docs
        "marksman",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        if client.server_capabilities.semanticTokensProvider then
          vim.lsp.semantic_tokens.start(bufnr, client.id)
        end
      end

      local base_config = {
        capabilities = capabilities,
        on_attach = on_attach
      }

      local server_configs = {
        bashls = {},
        pyright = {},
        sqlls = {},
        html = {},
        cssls = {},
        jsonls = {},
        yamlls = {},
        graphql = {},
        ts_ls = {},
        biome = {},
        terraformls = {},
        dockerls = {},
        taplo = {},
        lemminx = {},
        marksman = {},

        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for server, config in pairs(server_configs) do
        vim.lsp.config(server, vim.tbl_deep_extend("force", base_config, config))
        vim.lsp.enable(server)
      end
    end
  }
}
