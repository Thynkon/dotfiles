require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"go",
		"html",
		"java",
		"json",
		"lua",
		"markdown",
		"nix",
		"php",
		"python",
		"ruby",
		"rust",
		"scss",
		"toml",
--		"perl",  installation fails on nixos
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}
