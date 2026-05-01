return {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "bash",
  --     },
  --   },
  -- },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "harper-ls",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {},
      },
    },
  },
}
