-- Neotest configuration optimized for monorepo
-- Usage in monorepo:
--   1. cd to subrepo directory (e.g., :cd monorepo/a)
--   2. Use <leader>tc to reload neotest
--   3. Tests will only be discovered in current working directory

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-python",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
      "adrigzr/neotest-mocha",
    },
    config = function()
      -- Common filter to limit scanning to cwd
      local function get_cwd_filter()
        local cwd = vim.fn.getcwd()
        return function(name, rel_path, root)
          -- Exclude common directories
          local exclude = { "node_modules", ".git", "dist", "build", ".next", ".venv", "__pycache__", "target" }
          for _, dir in ipairs(exclude) do
            if name == dir then
              return false
            end
          end
          
          -- Build full path
          local full_path = root
          if rel_path and rel_path ~= "" then
            full_path = full_path .. "/" .. rel_path
          end
          full_path = full_path .. "/" .. name
          full_path = vim.fn.fnamemodify(full_path, ":p")
          
          -- Only allow paths within cwd
          local normalized_cwd = vim.fn.fnamemodify(cwd, ":p")
          return vim.startswith(full_path, normalized_cwd)
        end
      end

      require("neotest").setup({
        -- Force project root to be cwd
        default_strategy = "integrated",
        discovery = {
          enabled = true,
          concurrent = 1,
          filter_dir = get_cwd_filter(),
        },
        -- Only scan current working directory
        projects = {},
        adapters = {
          require("neotest-plenary"),
          require("neotest-mocha")({
            command = "npm test --",
            command_args = function(context)
              -- context contains:
              --   results_path: file for JSON results
              --   test_name: exact test name
              --   test_name_pattern: pattern for --grep
              --   path: path to test file
              return {
                "--full-trace",
                "--reporter=json",
                "--reporter-options=output=" .. context.results_path,
                "--grep=" .. context.test_name_pattern,
                context.path,
              }
            end,
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
            filter_dir = get_cwd_filter(),
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = function()
              local cwd = vim.fn.getcwd()
              local config_file = vim.fn.findfile("jest.config.js", cwd .. ";")
              return config_file ~= "" and config_file or "jest.config.js"
            end,
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
            filter_dir = get_cwd_filter(),
          }),
          require("neotest-vitest")({
            filter_dir = get_cwd_filter(),
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = function()
              return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
            end,
            -- CRITICAL: Add filter to Python adapter too
            is_test_file = function(file_path)
              -- Check if it's a test file
              if not vim.endswith(file_path, ".py") then
                return false
              end
              local filename = vim.fn.fnamemodify(file_path, ":t")
              if not (vim.startswith(filename, "test_") or vim.endswith(filename, "_test.py")) then
                return false
              end
              -- Check if within cwd
              local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
              local normalized = vim.fn.fnamemodify(file_path, ":p")
              return vim.startswith(normalized, cwd)
            end,
          }),
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),
        },
        quickfix = {
          enabled = false,
          open = false,
        },
        diagnostic = {
          enabled = true,
          severity = 1,
        },
        status = {
          enabled = true,
          virtual_text = true,
          signs = true,
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✖",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✓",
          running = "●",
          running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
          skipped = "○",
          unknown = "?",
          watching = "👁",
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },
        strategies = {
          integrated = {
            height = 40,
            width = 120,
          },
        },
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          open = "botright vsplit | vertical resize 50",
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },  -- Enter to expand/collapse
            expand_all = "e",
            jumpto = "i",  -- 'i' to jump to file
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t",
            watch = "w",
          },
        },
        output = {
          enabled = true,
          open_on_run = "short",
        },
        output_panel = {
          enabled = true,
          open = "botright split | resize 15",
        },
        run = {
          enabled = true,
        },
        watch = {
          enabled = true,
          symbol_queries = {
            python = "class",
            javascript = "(function_declaration)@symbol",
            typescript = "(function_declaration)@symbol",
          },
        },
      })
    end,
  }
}
