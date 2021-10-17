local key = require('lib/keybindings')

g.mapleader = ','
g.user_emmet_leader_key = '<C-Z>'
-- By default timeoutlen is 1000 ms
g.timeoutlen = 500

-- Go to normal mode when typing jk
key.map('i', 'jk', '<Esc>', {})

-- Make typing more comfortable
for mode in string.gmatch('nv','.') do
	key.map(mode, 'é', 'l', { noremap = true, silent = false })
	key.map(mode, 'l', 'k', { noremap = true, silent = false })
	key.map(mode, 'k', 'j', { noremap = true, silent = false })
	key.map(mode, 'j', 'h', { noremap = true, silent = false })
end

key.map('n', '<Space>', ':set hlsearch!<CR>', { noremap = true, silent = false })
key.map('n', '<leader>', ":WhichKey '<Space>'<CR>", { noremap = true, silent = true })
