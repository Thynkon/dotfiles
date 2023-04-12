local neotest = require("neotest")
local key = require("lib/keybindings")

neotest.setup(
  {
    adapters = {
      require("neotest-rust"),
      require("neotest-rspec"),
      require("neotest-elixir")
    }
  }
)

-- local opts = {noremap = true, silent = true}
-- opts.desc = "Toggle neotest UI"
-- key.map("n", "<leader>t", neotest.summary.toggle(), opts)
