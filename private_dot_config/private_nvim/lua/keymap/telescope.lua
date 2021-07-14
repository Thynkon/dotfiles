local key = require('lib/keybindings')

key.map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
key.map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
key.map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
key.map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
key.map('n', '<leader>fa', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", { noremap = true })
key.map('n', '<leader>fd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", { noremap = true })
