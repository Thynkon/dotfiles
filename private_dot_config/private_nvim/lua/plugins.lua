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
        use {'easymotion/vim-easymotion'}
        use {'Yggdroot/indentLine'}

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

        -- Git Support
        use {'tpope/vim-fugitive'}
        use {'airblade/vim-gitgutter'}

        -- Collection of common configurations for the Nvim LSP client
        use {'L3MON4D3/LuaSnip'}
        use {'neovim/nvim-lspconfig'}
        use {"wbthomason/lsp-status.nvim"}

        -- Install Lsp servers
        use {'williamboman/nvim-lsp-installer'}

        -- Lsp config
        use {'hrsh7th/nvim-cmp'}
        use {'hrsh7th/cmp-buffer'}
        use {'hrsh7th/cmp-path'}
        use {'hrsh7th/cmp-nvim-lua'}
        use {'hrsh7th/cmp-nvim-lsp'}
        use {'saadparwaiz1/cmp_luasnip'}
        use {"onsails/lspkind-nvim"}
        use {"tjdevries/colorbuddy.nvim"}

        -- For vsnip user.
        use {'hrsh7th/cmp-vsnip'}
        use {'hrsh7th/vim-vsnip'}

        -- Extentions to built-in LSP, for example, providing type inlay hints
        use {'tjdevries/lsp_extensions.nvim'}

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
        use({
                "NTBBloodbath/galaxyline.nvim",
                -- your statusline
                config = function()
                        require("galaxyline.themes.eviline")
                end,
                -- some optional icons
                requires = { "kyazdani42/nvim-web-devicons", opt = true }
        })

        use {'ryanoasis/vim-devicons'}
        use {'joshdick/onedark.vim'}
        -- launch terminal from neovim
        use {'akinsho/nvim-toggleterm.lua'}

        use {'kosayoda/nvim-lightbulb'}

        use {'mattn/emmet-vim'}
end)

return packer
