return {
  {
    "neovim/nvim-lspconfig",
    ft = "ruby",
    opts = {
      servers = {
        ruby_lsp = {
          mason = true,
        },
      },
    },
  },
}
