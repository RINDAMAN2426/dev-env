return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        actions = {
          open_file = {
            resize_window = true,
            window_picker = {
              enable = false,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        view = {
          adaptive_size = true,
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
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPost",
    config = function()
      require("fzf-lua").setup({
        'fzf-native',
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
        },
        files = {
          prompt = "Files > ",
          multiprocess = true,
          git_icons = true,
          file_icons = true,
          color_icons = true,
        },
        grep = {
          prompt = "Grep > ",
          multiprocess = true,
        },
      })
    end,
  }
}

