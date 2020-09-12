source ~/.config/nvim/basic.vim
source ~/.config/nvim/keybindings/standard.vim

if !exists('g:vscode')
  source ~/.config/nvim/plugins.vim
  source ~/.config/nvim/plugins/closetag.vim
  source ~/.config/nvim/plugins/coc.vim
  source ~/.config/nvim/plugins/fzf.vim
  source ~/.config/nvim/plugins/nerdcommenter.vim
  source ~/.config/nvim/theme/theme.vim
  source ~/.config/nvim/plugins/vimtest.vim

  source ~/.config/nvim/init/autocmd.vim
endif
