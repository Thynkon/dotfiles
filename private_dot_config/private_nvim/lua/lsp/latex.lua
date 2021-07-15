local lspconfig = require 'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require 'completion'.on_attach(client)
end

lspconfig.texlab.setup {
  cmd = { string.format("/usr/bin/texlab") },
  filetypes = { "tex", "bib" },
  -- root_dir = vim's starting directory
  settings = {
    bibtex = {
      formatting = {
        lineLength = 120
      }
    },
    latex = {
      rootDirectory = ".",
      build = {
        executable = "xelatex",
        -- %f: The path of the TeX file to compile.
        args = { "%f" },
        outputDirectory = "out",
        onSave = true
      },
      forwardSearch = {
        executable = "zathura",
        args = { "%p" },
        onSave = false
      },
      lint = {
        onChange = true,
        onSave = true
      }
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
