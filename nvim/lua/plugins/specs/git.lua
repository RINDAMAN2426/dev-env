return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = true,
      },

      watch_gitdir = { interval = 1000 },
      attach_to_untracked = false,
      update_debounce = 200,
      max_file_length = 10000,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gstatus", "GBrowse" },
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },
}
