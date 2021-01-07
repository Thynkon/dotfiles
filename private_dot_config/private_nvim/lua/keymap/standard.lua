vim.g.mapleader = ','
vim.g.user_emmet_leader_key = ','
-- By default timeoutlen is 1000 ms
vim.g.timeoutlen = 500

-- Go to normal mode when typing jk
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})

-- Make typing more comfortable
for mode in string.gmatch('nv','.') do
	vim.api.nvim_set_keymap(mode, 'é', 'l', { noremap = true, silent = false })
	vim.api.nvim_set_keymap(mode, 'l', 'k', { noremap = true, silent = false })
	vim.api.nvim_set_keymap(mode, 'k', 'j', { noremap = true, silent = false })
	vim.api.nvim_set_keymap(mode, 'j', 'h', { noremap = true, silent = false })
end

vim.api.nvim_set_keymap('n', '<Space>', ':set hlsearch!<CR>', { noremap = true, silent = false })

vim.api.nvim_set_keymap('n', '<leader>', ":WhichKey '<Space>'<CR>", { noremap = true, silent = true })
