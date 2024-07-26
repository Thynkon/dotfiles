return {
  -- Lazy.nvim
  {
    "hiasr/vim-zellij-navigator.nvim",
    config = function()
      require("vim-zellij-navigator").setup()
    end,
  },
}
