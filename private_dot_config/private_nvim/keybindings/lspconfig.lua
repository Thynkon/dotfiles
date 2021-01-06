-- Code navigation shortcuts
-- as found in :help lsp
vim.api.nvim_set_keymap('n', '<c-]>', "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '1gD', "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g0', "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gW', "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", { noremap = true, silent = true })
-- rust-analyzer does not yet support goto declaration
-- re-mapped `gd` to definition
vim.api.nvim_set_keymap('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Trigger completion with <tab>
-- found in :help completion
-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i', '<expr> <Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true })
vim.api.nvim_set_keymap('i', '<expr> <S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true })

-- use <Tab> as trigger keys
vim.api.nvim_set_keymap('i', '<Tab>', '<Plug>(completion_smart_tab)', {})
vim.api.nvim_set_keymap('i', '<S-Tab>', '<Plug>(completion_smart_s_tab)', {})

-- Goto previous/next diagnostic warning/error
vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
