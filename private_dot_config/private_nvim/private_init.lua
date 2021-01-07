local config_dir = os.getenv("XDG_CONFIG_HOME")

require('basic')
require('keymap.standard')

if vim.api.nvim_eval('!exists("g:vscode")') then
  require('keymap.lspconfig')
  require('plugins')

  vim.api.nvim_command(string.format('source %s/nvim/theme/theme.vim', config_dir))

  require('lsp.latex')
  require('lsp.css')
  require('lsp.go')
  require('lsp.html')
  require('lsp.javascript')
  require('lsp.json')
  require('lsp.lua')
  require('lsp.php')
  require('lsp.python')
  require('lsp.rust')
  require('lsp.shell')
  require('lsp.sql')

  require('plugin.closetag')
  require('plugin.nerdcommenter')
  require('plugin.easymotion')
  require('plugin.vim-vinegar')
  require('plugin.treesitter')

  vim.api.nvim_command(string.format('source %s/nvim/autoload/autocmd.vim', config_dir))
end
