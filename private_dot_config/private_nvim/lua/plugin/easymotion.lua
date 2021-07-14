local key = require('lib/keybindings')

-- Turn on case-insensitive feature
g.EasyMotion_smartcase = 1

-- Move to line
key.map('', '<leader><leader>L', '<Plug>(easymotion-bd-jk)', {})
key.map('n', '<leader><leader>L', '<Plug>(easymotion-bd-jk)', {})

-- up and down motions: Line motions
key.map('', '<leader><leader>k', '<Plug>(easymotion-j)', {})
key.map('', '<leader><leader>l', '<Plug>(easymotion-k)', {})
