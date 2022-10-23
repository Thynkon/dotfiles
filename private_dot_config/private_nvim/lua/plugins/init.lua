-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
local packer = require("packer")

packer.startup(
  function()
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}
    -- Make sure you use single quotes
    -- Utility
    use {"kylechui/nvim-surround"}
    use {"numToStr/Comment.nvim"}
    use {
      "phaazon/hop.nvim",
      branch = "v2" -- optional but strongly recommended
    }
    use {"Yggdroot/indentLine"} -- format code
    use {"mhartington/formatter.nvim"}

    -- Generic Programming Support
    -- Vim plugin, insert or delete brackets, parens, quotes in pair
    use {"RRethy/nvim-treesitter-endwise"}
    use {"windwp/nvim-autopairs"}

    -- Markdown / Writting
    use {"lervag/vimtex"}

    -- Git Support
    use {"APZelos/blamer.nvim"}
    use {"lewis6991/gitsigns.nvim"}

    -- Collection of common configurations for the Nvim LSP client
    use {"L3MON4D3/LuaSnip"}
    -- vscode like snippets
    use {"rafamadriz/friendly-snippets"}
    use {"neovim/nvim-lspconfig"}
    use {"wbthomason/lsp-status.nvim"}

    -- Install Lsp servers
    use {"williamboman/mason.nvim"}
    use {"williamboman/mason-lspconfig.nvim"}
    -- Install formatters, linters (based on mason API)
    use {"WhoIsSethDaniel/mason-tool-installer.nvim"}

    -- Lsp config
    use {"hrsh7th/nvim-cmp"}
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
    use {"kosayoda/nvim-lightbulb"} -- Viewer & Finder for LSP symbols and tags
    use {"liuchengxu/vista.vim"}

    -- Async linter
    use {"mfussenegger/nvim-lint"}

    -- For vsnip user.
    use {"hrsh7th/cmp-vsnip"}
    use {"hrsh7th/vim-vsnip"}

    -- Extentions to built-in LSP, for example, providing type inlay hints
    use {"tjdevries/lsp_extensions.nvim"}

    -- Debugger
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}

    -- Filemanager
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
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
    use "rebelot/heirline.nvim"
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }

    use "nvim-treesitter/playground"
    use {"kyazdani42/nvim-web-devicons"}
    use {"navarasu/onedark.nvim"}
    use "EdenEast/nightfox.nvim" -- Packer
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons" -- optional, for file icons
      },
      tag = "nightly" -- optional, updated every week. (see issue #1193)
    }

    use {"ryanoasis/vim-devicons"}
    use {"joshdick/onedark.vim"}

    use {"mattn/emmet-vim"}

    use {"folke/which-key.nvim"}
  end
)

return packer
