-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
local packer = require("packer")
local use = packer.use

packer.startup(
  function()
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}
    -- Make sure you use single quotes
    -- Utility
    use {"kylechui/nvim-surround"}
    use {
      "numToStr/Comment.nvim",
      config = function()
        require "plugins.config.comment-nvim"
      end
    }
    use {
      "phaazon/hop.nvim",
      branch = "v2", -- optional but strongly recommended
      config = function()
        require "plugins.config.hop-nvim"
      end
    }
    use {"Yggdroot/indentLine"} -- format code
    use {
      "mhartington/formatter.nvim",
      config = function()
        require "plugins.config.formatter-nvim"
      end
    }

    -- Generic Programming Support
    -- Vim plugin, insert or delete brackets, parens, quotes in pair
    use {"RRethy/nvim-treesitter-endwise"}
    use {
      "windwp/nvim-autopairs",
      config = function()
        require "plugins.config.formatter-nvim"
      end
    }

    -- Markdown / Writting
    use {"lervag/vimtex"}
    use {
      "nvim-orgmode/orgmode",
      requires = {"nvim-treesitter/nvim-treesitter"},
      config = function()
        require "plugins.config/orgmode"
      end
    }

    -- Git Support
    use {"APZelos/blamer.nvim"}
    use {"lewis6991/gitsigns.nvim"}

    -- Collection of common configurations for the Nvim LSP client
    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require "plugins.config.luasnip"
      end
    }
    -- vscode like snippets
    use {"rafamadriz/friendly-snippets"}
    use {"neovim/nvim-lspconfig"}
    use {"wbthomason/lsp-status.nvim"}

    -- Install Lsp servers
    use {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require "plugins.config.mason-nvim"
        end
      }
    }
    -- Install formatters, linters (based on mason API)
    use {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      requires = {"williamboman/mason.nvim"}
    }

    -- Lsp config
    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require "plugins.config.nvim-cmp"
      end
    }
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-calc"}
    use {"hrsh7th/cmp-nvim-lsp-document-symbol"}
    use {"hrsh7th/cmp-nvim-lua"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"lukas-reineke/cmp-rg"}
    use {"saadparwaiz1/cmp_luasnip"}
    use {"onsails/lspkind-nvim"}
    use {"tjdevries/colorbuddy.nvim"} -- VSCode 💡 for neovim's built-in LSP
    use {
      "kosayoda/nvim-lightbulb",
      config = function()
        require "plugins.config/nvim-lightbulb"
      end
    } -- Viewer & Finder for LSP symbols and tags
    use {"liuchengxu/vista.vim"}

    -- Async linter
    use {
      "mfussenegger/nvim-lint",
      config = function()
        require "plugins.config.nvim-lint"
      end
    }

    -- For vsnip user.
    use {"hrsh7th/cmp-vsnip"}
    use {"hrsh7th/vim-vsnip"}

    -- Extentions to built-in LSP, for example, providing type inlay hints
    use {"tjdevries/lsp_extensions.nvim"}

    -- Debugger
    use {
      "rcarriga/nvim-dap-ui",
      requires = {"mfussenegger/nvim-dap"},
      config = function()
        require "plugins.config.nvim-dap-ui"
      end
    }

    -- Filemanager
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
      config = function()
        require "plugins.config.telescope"
      end
    }

    -- Theme / Interface
    use {"norcalli/nvim-colorizer.lua"}
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        vim.api.nvim_command("TSUpdate")
      end
    }
    -- Status line
    use {
      "rebelot/heirline.nvim",
      config = function()
        require "plugins.config.heirline-nvim"
      end
    }
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }

    use "nvim-treesitter/playground"
    use {"kyazdani42/nvim-web-devicons"}
    use "EdenEast/nightfox.nvim" -- Packer
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons" -- optional, for file icons
      },
      tag = "nightly", -- optional, updated every week. (see issue #1193)
      config = function()
        require "plugins.config.nvim-tree"
      end
    }

    use {"ryanoasis/vim-devicons"}

    use {
      "mattn/emmet-vim",
      config = function()
        require "plugins.config.emmet"
      end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require "plugins.config.which-key-nvim"
      end
    }
  end
)

return packer
