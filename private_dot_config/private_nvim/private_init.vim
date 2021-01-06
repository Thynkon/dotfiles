luafile $XDG_CONFIG_HOME/nvim/basic.lua
luafile $XDG_CONFIG_HOME/nvim/keybindings/standard.lua

if !exists('g:vscode')
  luafile $XDG_CONFIG_HOME/nvim/keybindings/lspconfig.lua
  lua require('plugins')
  luafile $XDG_CONFIG_HOME/nvim/plugins/closetag.lua

  luafile $XDG_CONFIG_HOME/nvim/plugins/nerdcommenter.lua
  luafile $XDG_CONFIG_HOME/nvim/plugins/easymotion.lua
  source $XDG_CONFIG_HOME/nvim/theme/theme.vim

  lua require('lsp.latex')
  lua require('lsp.css')
  lua require('lsp.go')
  lua require('lsp.html')
  lua require('lsp.javascript')
  lua require('lsp.json')
  lua require('lsp.lua')
  lua require('lsp.php')
  lua require('lsp.python')
  lua require('lsp.rust')
  lua require('lsp.shell')
  lua require('lsp.sql')

  luafile $XDG_CONFIG_HOME/nvim/plugins/vim-vinegar.lua
  source $XDG_CONFIG_HOME/nvim/plugins/vista.vim
  luafile $XDG_CONFIG_HOME/nvim/plugins/treesitter.lua

  source $XDG_CONFIG_HOME/nvim/autoload/autocmd.vim
endif

