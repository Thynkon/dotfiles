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
		"nix",
--		"perl",  installation fails on nixos
		"php",
		"python",
		"ruby",
		"rust",
		"scss",
		"toml",
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}
