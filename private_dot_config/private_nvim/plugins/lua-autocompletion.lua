local cache_dir = os.getenv("XDG_CACHE_HOME")

require'nvim_lsp'.sumneko_lua.setup{
  cmd = {string.format("%s/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "%s/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua", cache_dir, cache_dir) },
  install_dir = string.format("%s/nvim/nvim_lsp/sumneko_lua", cache_dir),
  is_installed = true
}
