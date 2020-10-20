source $XDG_CONFIG_HOME/nvim/basic.vim
source $XDG_CONFIG_HOME/nvim/keybindings/standard.vim

if !exists('g:vscode')
  source $XDG_CONFIG_HOME/nvim/plugins.vim
  source $XDG_CONFIG_HOME/nvim/plugins/closetag.vim
  source $XDG_CONFIG_HOME/nvim/plugins/coc/coc.vim
  source $XDG_CONFIG_HOME/nvim/plugins/coc/fzf-preview.vim
  source $XDG_CONFIG_HOME/nvim/plugins/nerdcommenter.vim
  source $XDG_CONFIG_HOME/nvim/plugins/easymotion.vim
  source $XDG_CONFIG_HOME/nvim/theme/theme.vim
  source $XDG_CONFIG_HOME/nvim/plugins/vimtest.vim
  source $XDG_CONFIG_HOME/nvim/plugins/lua-autocompletion.vim
  source $XDG_CONFIG_HOME/nvim/plugins/vim-vinegar.vim
  luafile $XDG_CONFIG_HOME/nvim/plugins/treesitter.lua

  source $XDG_CONFIG_HOME/nvim/autoload/autocmd.vim
endif
