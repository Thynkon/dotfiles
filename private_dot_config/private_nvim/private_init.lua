local config_dir = os.getenv("XDG_CONFIG_HOME")

require('basic')
require('keymap.standard')
if vim.api.nvim_eval('!exists("g:vscode")') then
  require('keymap.lspconfig')
  require('keymap.telescope')
  require('plugins')

  require('theme/theme')

  require('lsp.c')
  require('lsp.css')
  require('lsp.go')
  require('lsp.html')
  require('lsp.javascript')
  require('lsp.json')
  require('lsp.latex')
  require('lsp.lua')
  require('lsp.perl')
  require('lsp.php')
  require('lsp.python')
  require('lsp.rust')
  require('lsp.shell')
  require('lsp.sql')

  require('plugin.closetag')
  require('plugin.easymotion')
  require('plugin.nerdcommenter')
  require('plugin.telescope')
  require('plugin.treesitter')
  require('plugin.vim-vinegar')
  require('plugin.nvim-toggleterm')

  vim.api.nvim_command(string.format('source %s/nvim/autoload/autocmd.vim', config_dir))
end
