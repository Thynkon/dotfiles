require("lib.aliases")

local a = require("lib/autocmd")

a.c(
  {"BufEnter", "BufWinEnter"},
  {
    pattern = {"*"},
    callback = function()
      vim.diagnostic.open_float()
    end
  }
)
a.c(
  {"CursorHold", "CursorHoldI"},
  {
    pattern = {"*"},
    callback = function()
      require("nvim-lightbulb").update_lightbulb()
    end
  }
)

a.c(
  {"CursorHold", "CursorHoldI"},
  {
    pattern = {"*.html", "*.css"},
    command = "EmmetInstall"
  }
)

a.g("YankHighlight", {clear = true})
a.c(
  {"TextYankPost"},
  {
    pattern = {"*"},
    callback = function()
      vim.highlight.on_yank()
    end
  }
)

a.g("FormatAutogroup", {clear = true})
a.c(
  {"BufWritePost"},
  {
    callback = function()
      api.nvim_command("FormatWrite")
    end
  }
)
