local lspconfig = require 'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.intelephense.setup {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
  settings = {
  },
  on_attach = on_attach
}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
