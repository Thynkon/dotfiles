return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      elixir.setup({
        nextls = {
          enable = true,
          init_options = {
            mix_env = "dev",
            mix_target = "host",
            experimental = {
              completions = {
                enable = false, -- control if completions are enabled. defaults to false
              },
            },
          },
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    lazy = true,
    ft = "elixir",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir-ls",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    ft = "elixir",
    lazy = true,
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      servers = {
        elixirls = {
          cmd = { os.getenv("HOME") .. "/.local/share/nvim/mason/bin/elixir-ls" },
          filetypes = { "elixir", "eelixir", "heex", "surface" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("mix.exs")(fname)
          end,
          settings = {
            elixirLS = {
              dialyzerEnabled = true,
              fetchDeps = false,
              enableTestLenses = false,
              suggestSpecs = true,
            },
          },
        },
      },
    },
  },
}
