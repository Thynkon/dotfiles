-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
local packer = require("packer")

packer.startup(
  function()
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}
    -- Make sure you use single quotes
    -- Utility
    use {"tpope/vim-surround"} -- TODO: find another plugin
    use {"preservim/nerdcommenter"}
    use {"easymotion/vim-easymotion"} -- show identation levels
    use {"Yggdroot/indentLine"} -- format code
    use {"mhartington/formatter.nvim"}

    -- Generic Programming Support
    -- Vim plugin, insert or delete brackets, parens, quotes in pair
    use {"jiangmiao/auto-pairs"}
    use {"alvan/vim-closetag"}
    use {"tpope/vim-endwise"}

    -- Markdown / Writting
    use {"lervag/vimtex"}

    -- Git Support
    use {"airblade/vim-gitgutter"}
    use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"} -- gitlens for nvim
    use {"APZelos/blamer.nvim"}

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

    -- Ruby
    -- -- use {"suketa/nvim-dap-ruby", requires = "mfussenegger/nvim-dap"} -- debugger

    -- Filemanager
    use {"vifm/vifm.vim"} -- Search through files
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
    use "nvim-treesitter/playground"
    use {"kyazdani42/nvim-web-devicons"}
    use {"navarasu/onedark.nvim"}
    use "EdenEast/nightfox.nvim" -- Packer
    use(
      {
        "feline-nvim/feline.nvim",
        requires = {"SmiteshP/nvim-gps", opt = true}
      }
    )
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

    use {"SmiteshP/nvim-gps"}
  end
)

return packer
