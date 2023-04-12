local key = require("lib/keybindings")

key.map("n", "<F5>", ":w <bar> exec '!make'<CR>", {noremap = true})
