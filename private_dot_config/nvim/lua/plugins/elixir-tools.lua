return {
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
}
