local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_err_writeln("lazy.nvim not found")
  return
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {  import = "plugins.specs"  },
  },
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = {  "default"  },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
