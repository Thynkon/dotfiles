return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      exclude = {
        ".git",
        "node_modules",
        "target",
      },
    },
  },
}
