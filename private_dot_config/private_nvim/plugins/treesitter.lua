require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"c", "php", "bash", "java", "cpp", "html", "css", "json", "go", "python", "ruby", "toml", "lua"
	},
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}
