luafile $XDG_CONFIG_HOME/nvim/basic.lua
luafile $XDG_CONFIG_HOME/nvim/keybindings/standard.lua

if !exists('g:vscode')
  source $XDG_CONFIG_HOME/nvim/plugins/plugins.vim
  luafile $XDG_CONFIG_HOME/nvim/plugins/closetag.lua
  source $XDG_CONFIG_HOME/nvim/plugins/coc/coc.vim
  source $XDG_CONFIG_HOME/nvim/plugins/coc/fzf-preview.vim
  luafile $XDG_CONFIG_HOME/nvim/plugins/nerdcommenter.lua
  luafile $XDG_CONFIG_HOME/nvim/plugins/easymotion.lua
  source $XDG_CONFIG_HOME/nvim/theme/theme.vim
  source $XDG_CONFIG_HOME/nvim/plugins/vimtest.vim
  luafile $XDG_CONFIG_HOME/nvim/plugins/lua-autocompletion.lua
  luafile $XDG_CONFIG_HOME/nvim/plugins/vim-vinegar.lua
  luafile $XDG_CONFIG_HOME/nvim/plugins/treesitter.lua

  source $XDG_CONFIG_HOME/nvim/autoload/autocmd.vim
endif

