return {
  {
    "smoka7/hop.nvim",
    version = "*",
    keys = {
      {
        "<leader><leader>w",
        function()
          require("hop").hint_words()
        end,
        desc = "Hop to word",
      },
      {
        "<leader><leader>l",
        function()
          require("hop").hint_lines()
        end,
        desc = "Hop to line",
      },
      {
        "<leader><leader>p",
        function()
          require("hop").hint_patterns()
        end,
        desc = "Hop to pattern",
      },
    },
    opts = { keys = "etovxqpdygfblzhckisuran" },
    lazy = true,
  },
}
