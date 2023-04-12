return {
	{ "kylechui/nvim-surround", tag = "v1.0.0" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.config.comment-nvim")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("plugins.config.hop-nvim")
		end,
	},
	{ "Yggdroot/indentLine" }, -- format code
	-- Generic Programming Support
	-- Vim plugin, insert or delete brackets, parens, quotes in pair
	{ "RRethy/nvim-treesitter-endwise" },
	{ "windwp/nvim-autopairs" },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("plugins.config.nvim-ufo")
		end,
	},
	-- Markdown / Writting
	{ "lervag/vimtex" },
	{ "sile-typesetter/vim-sile" },
	{
		"nvim-orgmode/orgmode",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("plugins.config/orgmode")
		end,
	},
	-- Git Support
	{
		"APZelos/blamer.nvim",
		config = function()
			require("plugins.config.blamer-nvim")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.config.gitsigns-nvim")
		end,
	},
	-- Git conflicts
	{
		"akinsho/git-conflict.nvim",
		config = function()
			-- require("plugins.git-conflict")
		end,
	},
	-- Collection of common configurations for the Nvim LSP client
	{
		"L3MON4D3/LuaSnip",
		tag = "v1.1.0",
		config = function()
			require("plugins.config.luasnip")
		end,
	}, -- vscode like snippets
	{ "rafamadriz/friendly-snippets" },
	{ "neovim/nvim-lspconfig" },
	{ "wbthomason/lsp-status.nvim" }, -- Install Lsp servers
	{
		"williamboman/mason.nvim",
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("plugins.config.mason-nvim")
			end,
		},
	}, -- Install formatters, linters (based on mason API)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
	}, -- Lsp config
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"lukas-reineke/cmp-rg",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		event = "InsertEnter",
		config = function()
			require("plugins.config.nvim-cmp")
		end,
		commit = "e7e2ef7031db8e0cfad7ad9916ec766ddd9dbb3b",
	},
	{ "onsails/lspkind-nvim" },
	{ "tjdevries/colorbuddy.nvim" },
	-- Viewer & Finder for LSP symbols and tags
	{
		"liuchengxu/vista.vim",
	},
	-- Async linter
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.config/null-ls")
		end,
		commit = "7b2b28e207a1df4ebb13c7dc0bd83f69b5403d71",
	},

	-- Extentions to built-in LSP, for example, providing type inlay hints
	{ "tjdevries/lsp_extensions.nvim" },

	-- Debugger
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("plugins.config.nvim-dap-ui")
		end,
	},
	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"jfpedroza/neotest-elixir",
			"rouge8/neotest-rust",
			"olimorris/neotest-rspec",
		},
		config = function()
			require("plugins.config.neotest")
		end,
	},
	-- Filemanager
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = function()
			require("plugins.config.telescope")
		end,
	},
	-- Theme / Interface
	{ "norcalli/nvim-colorizer.lua" },
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			vim.api.nvim_command("TSUpdate")
		end,
	},
	{ "rebelot/kanagawa.nvim" },
	-- Notifications
	{
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.config.nvim-notify")
		end,
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.config.nvim-lualine")
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	"nvim-treesitter/playground",
	{ "kyazdani42/nvim-web-devicons" },
	{
		"EdenEast/nightfox.nvim",
		event = "VeryLazy",
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			require("plugins.config.nvim-tree")
		end,
	},
	{ "ryanoasis/vim-devicons" },
	{
		"mattn/emmet-vim",
		config = function()
			require("plugins.config.emmet")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.config.which-key-nvim")
		end,
	},
}
