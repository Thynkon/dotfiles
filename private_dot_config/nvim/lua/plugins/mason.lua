return {
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elp",
        "asm-lsp",
      })
    end,
  },
}
