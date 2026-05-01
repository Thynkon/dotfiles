return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      server = {
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            files = {
              excludeDirs = {
                vim.fn.expand("$HOME/.local/share/cargo/registry"),
              },
              watcherExclude = {
                "**/.local/share/cargo/registry/**",
              },
            },
          },
        },
      },
    },
  },
}
