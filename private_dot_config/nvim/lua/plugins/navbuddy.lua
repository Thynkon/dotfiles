return {
  {
    "SmiteshP/nvim-navbuddy",
    opts = {
      lsp = { auto_attach = true },
      window = {
        border = "single", -- "rounded", "double", "solid", "none"
        -- or an array with eight chars building up the border in a clockwise fashion
        -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
        size = "90%",
      },
      mappings = {
        ["k"] = require("nvim-navbuddy.actions").next_sibling(), -- down
        ["l"] = require("nvim-navbuddy.actions").previous_sibling(), -- up

        ["j"] = require("nvim-navbuddy.actions").parent(), -- Move to left panel
        ["é"] = require("nvim-navbuddy.actions").children(), -- Move to right panel

        ["K"] = require("nvim-navbuddy.actions").move_down(), -- Move focused node down
        ["L"] = require("nvim-navbuddy.actions").move_up(), -- Move focused node up
      },
    },
  },
}
