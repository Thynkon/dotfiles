local lspconfig = require'lspconfig'
lspconfig.sumneko_lua.setup {
  cmd = {"lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
}
