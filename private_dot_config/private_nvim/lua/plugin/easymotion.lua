-- Turn on case-insensitive feature
vim.g.EasyMotion_smartcase = 1

-- Move to line
vim.api.nvim_set_keymap('', '<leader><leader>L', '<Plug>(easymotion-bd-jk)', {})
vim.api.nvim_set_keymap('n', '<leader><leader>L', '<Plug>(easymotion-bd-jk)', {})

-- up and down motions: Line motions
vim.api.nvim_set_keymap('', '<leader><leader>k', '<Plug>(easymotion-j)', {})
vim.api.nvim_set_keymap('', '<leader><leader>l', '<Plug>(easymotion-k)', {})
