local lspconfig = require 'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.jsonls.setup {
  cmd = { "vscode-json-languageserver", "--stdio" },
  filetypes = { "json" },
  root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
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
