return {
  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    config = function()
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      require('dashboard').setup {
        theme = 'hyper',
        config = {
          header = {},
          shortcut = {},
          footer = {},
        }
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
}
