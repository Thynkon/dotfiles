local lspconfig = require 'lspconfig'
local data_dir = os.getenv("XDG_DATA_HOME")

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.sqlls.setup {
  cmd = { "sql-language-server", "up"; "--method", "stdio"},
  filetypes = { "sql", "mysql" },
  settings = {},
  on_attach = on_attach
}

-- Enable diagnostics
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
