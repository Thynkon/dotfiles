local present, hop = pcall(require, "hop")

if not present then
  return
end

local key = require("lib/keybindings")

hop.setup {
  keys = "etovxqpdygfblzhckisuran"
}

key.map("n", "<leader><leader>w", hop.hint_words, {desc = "Jump to the beggining of words"})
key.map("n", "<leader><leader>l", hop.hint_lines, {desc = "Jump to the beggining of lines"})
key.map("n", "<leader><leader>p", hop.hint_patterns, {desc = "Jump to a pattern (similar to /)"})
