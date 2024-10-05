return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elp",
        "jdtls",
        "perlnavigator",
        "typst-lsp",
        "zls",
      })
    end,
  },
}
