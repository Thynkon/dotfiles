-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
local packer = require('packer')

packer.startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}
  -- Make sure you use single quotes
  -- Utility
  use {'tpope/vim-vinegar'}
  use {'liuchengxu/vista.vim'}
  use {'wesQ3/vim-windowswap'}
  use {'tpope/vim-dispatch'}
  use {'tpope/vim-surround'}
  use {'preservim/nerdcommenter'}
  -- adjust tab size automatically
  use {'tpope/vim-sleuth'}
  use {'easymotion/vim-easymotion'}
  use {'Yggdroot/indentLine'}
  use {'liuchengxu/vim-which-key'}

  -- Generic Programming Support
  -- snippets
  use {
    'honza/vim-snippets',
    requires = 'SirVer/ultisnips',
  }
  -- Vim plugin, insert or delete brackets, parens, quotes in pair
  use {'jiangmiao/auto-pairs'}
  use {'alvan/vim-closetag'}

  -- Markdown / Writting
  use {'tpope/vim-markdown'}
  use {'dpelle/vim-LanguageTool'}
  use {'lervag/vimtex'}
  use { -- org mode
    "vhyrro/neorg",
    config = function()
      require('neorg').setup {
	-- Tell Neorg what modules to load
	load = {
	  ["core.defaults"] = {}, -- Load all the default modules
	  ["core.norg.concealer"] = {}, -- Allows for use of icons
	  ["core.norg.dirman"] = { -- Manage your directories with Neorg
	    config = {
	      workspaces = {
	      my_workspace = "~/neorg"
	      }
	    }
	  }
	},
      }
    end,
    requires = "nvim-lua/plenary.nvim"
  }

  -- Git Support
  use {'tpope/vim-fugitive'}
  use {'airblade/vim-gitgutter'}

  -- Collection of common configurations for the Nvim LSP client
  use {'neovim/nvim-lspconfig'}
  -- Extentions to built-in LSP, for example, providing type inlay hints
  use {'tjdevries/lsp_extensions.nvim'}
  -- Autocompletion framework for built-in LSP
  use {'nvim-lua/completion-nvim'}

  -- Filemanager
  use {'vifm/vifm.vim'}
  -- Search through files
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Python
  -- pep8 indentation
  use {'Vimjas/vim-python-pep8-indent'}

  -- Theme / Interface
  use {'norcalli/nvim-colorizer.lua'}
  --Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  -- We recommend updating the parsers on update
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      vim.api.nvim_command('TSUpdate')
    end

  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'ryanoasis/vim-devicons'}
  use {'joshdick/onedark.vim'}
  -- launch terminal from neovim
  use {'akinsho/nvim-toggleterm.lua'}

  use {'kosayoda/nvim-lightbulb'}

  use {'mattn/emmet-vim'}
end)

return packer
