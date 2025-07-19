return {
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tinymist",
      })
    end,
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
