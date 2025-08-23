return {
  {
    "SmiteshP/nvim-navbuddy",
    event = "LspAttach",
    opts = function()
      local actions = require("nvim-navbuddy.actions")
      return {
        lsp = { auto_attach = true },
        window = {
          border = "single",
          size = "90%",
        },
        mappings = {
          ["k"] = actions.next_sibling(),
          ["l"] = actions.previous_sibling(),
          ["j"] = actions.parent(),
          ["é"] = actions.children(),
          ["K"] = actions.move_down(),
          ["L"] = actions.move_up(),
        },
      }
    end,
  },
}
