local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

g.mapleader = ","
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			"folke/LazyVim",
			dev = false,
			lazy = false,
			priority = 10000,
		},
		{
			import = "plugins",
		},
	},
	defaults = {
		lazy = false,
		version = "*",
	},
	install = {
		colorscheme = { "nightfox" },
	},
	checker = {
		enabled = true,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
