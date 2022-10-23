local key = require("lib/keybindings")
local builtin = require("telescope.builtin")

key.map("n", "<leader>ff", builtin.find_files, {noremap = true, desc = "Find file"})
key.map("n", "<leader>fg", builtin.live_grep, {noremap = true, desc = "Find content in file"})
key.map("n", "<leader>fb", builtin.buffers, {noremap = true})
key.map("n", "<leader>fh", builtin.help_tags, {noremap = true})

key.map("n", "<leader>mp", builtin.man_pages, {noremap = true, desc = "List manpages entries"})
key.map(
  "n",
  "<leader>fd",
  builtin.lsp_definitions,
  {noremap = true, desc = "Goto the definition of the word under the cursor"}
)
