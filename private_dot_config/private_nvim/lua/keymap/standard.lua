local ls = require "luasnip"
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

-- -- <c-k> is my expansion key
-- -- this will expand the current item or jump to the next item within the snippet.
-- vim.keymap.set({ "i", "s" }, "<C-k>", function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })
--
-- -- <c-j> is my jump backwards key.
-- -- this always moves to the previous item within the snippet
-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
--   if ls.jumpable(-1) then
--     ls.jump(-1)
--   end
-- end, { silent = true })
--
-- -- <c-l> is selecting within a list of options.
-- -- This is useful for choice nodes (introduced in the forthcoming episode 2)
-- vim.keymap.set("i", "<c-l>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end)
--
-- vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")
--
-- -- shorcut to source my luasnips file again, which will reload my snippets
-- -- vim.keymap.set("n", "<leader>sp", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
