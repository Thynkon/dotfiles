return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 1000 },
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        vtsls = {},
      },
    },
  },
}
