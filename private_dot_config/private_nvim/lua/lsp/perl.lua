local lspconfig = require 'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.perlls.setup {
  cmd = { "perl", "-MPerl::LanguageServer", "-e", "Perl::LanguageServer::run", "--", "--port 13603", "--nostdio 0", "--version 2.1.0" },
  filetypes = { "perl" },
  -- root_dir = vim's starting directory
  settings = {
    perl = {
      fileFilter = { ".pm", ".pl" },
      ignoreDirs = ".git",
      perlCmd = "perl",
      perlInc = " "
    }
  },
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
