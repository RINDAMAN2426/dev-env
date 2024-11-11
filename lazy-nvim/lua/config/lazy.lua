-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		version = false, -- always use the lastest git commit
		-- version = "*", -- try installing the lastest stable version for plugins that support semver
	},
	checker = {
		enabled = true, -- check for plugin updates periodically
		notify = false, -- notify on update
	},
})

-- Show Dashboard only when opening Neovim without any files, such as when opening a directory
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--    if vim.fn.argc() == 0 then
--       vim.cmd("Dashboard")
--     end
--   end
-- })
