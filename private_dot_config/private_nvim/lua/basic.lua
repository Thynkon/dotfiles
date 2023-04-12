local key = require("lib/keybindings")

cmd("syntax on")

opt.wrap = false

-- Incrementally highlights ALL pattern matches
opt.incsearch = true
-- align the new line indent with the previous line
opt.autoindent = true

-- Show linenumbers
opt.number = true
opt.relativenumber = true
opt.ruler = true

-- lines longer than 79 columns will be broken
bo.textwidth = 79

-- Copy to system's clipboard using yy
o.clipboard = "unnamedplus"

-- Always display the status line
o.laststatus = 2

-- Enable highlighting of the current line
opt.cursorline = true

-- if hidden is not set, TextEdit might fail.
opt.hidden = true

-- Some servers have issues with backup files, see #649
opt.backup = false
opt.writebackup = false

-- Better display for messages
o.cmdheight = 2

-- You will have bad experience for diagnostic messages when it's default 4000.
o.updatetime = 300

-- don't give |ins-completion-menu| messages.
o.shortmess = o.shortmess .. "c"

-- always show signcolumns
wo.signcolumn = "yes"

o.inccommand = "nosplit"

-- Set completeopt to have a better completion experience
o.completeopt = "menuone,noinsert,noselect"

api.nvim_command("filetype plugin indent on")
bo.tabstop = 4
bo.shiftwidth = 4
-- go.expandtab = true
vim.cmd("set expandtab")

-- Disable arrow movement, resize splits instead.
key.map("n", "<Up>", ":resize -2<CR>", {noremap = true})
key.map("n", "<Down>", ":resize +2<CR>", {noremap = true})
key.map("n", "<Left>", ":vertical resize -2<CR>", {noremap = true})
key.map("n", "<Right>", ":vertical resize +2<CR>", {noremap = true})
