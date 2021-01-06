vim.cmd('syntax on')

vim.wo.wrap = false

-- Incrementally highlights ALL pattern matches
vim.o.incsearch = true
-- align the new line indent with the previous line
vim.bo.autoindent = true

-- Show linenumbers
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.ruler = true

-- lines longer than 79 columns will be broken
vim.bo.textwidth = 79

-- Copy to system's clipboard using yy
vim.o.clipboard = 'unnamedplus'

-- Always display the status line
vim.o.laststatus = 2

-- Enable highlighting of the current line
vim.wo.cursorline = true

-- if hidden is not set, TextEdit might fail.
vim.o.hidden = true

-- Some servers have issues with backup files, see #649
vim.o.backup = false
vim.o.writebackup = false

-- Better display for messages
vim.o.cmdheight = 2

-- You will have bad experience for diagnostic messages when it's default 4000.
vim.o.updatetime = 300

-- don't give |ins-completion-menu| messages.
vim.o.shortmess = vim.o.shortmess .. 'c'

-- always show signcolumns
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

vim.api.nvim_command('filetype plugin indent on')

-- Disable arrow movement, resize splits instead.
vim.api.nvim_set_keymap('n', '<Up>', ':resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', ':resize +2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize +2<CR>', {noremap = true})
