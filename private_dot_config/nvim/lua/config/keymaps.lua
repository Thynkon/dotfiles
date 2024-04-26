-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Go to normal mode when typing jk
vim.keymap.set("i", "jk", "<Esc>", {})

-- Make typing more comfortable
for mode in string.gmatch("nv", ".") do
  vim.keymap.set(mode, "é", "l", {
    noremap = true,
    silent = false,
  })
  vim.keymap.set(mode, "l", "k", {
    noremap = true,
    silent = false,
  })
  vim.keymap.set(mode, "k", "j", {
    noremap = true,
    silent = false,
  })
  vim.keymap.set(mode, "j", "h", {
    noremap = true,
    silent = false,
  })
end

vim.keymap.set("n", "<leader>nb", function()
  require("nvim-navbuddy").open()
end, {
  desc = "Open LSP navigation bar",
})

vim.keymap.set("n", "<Space>", ":set hlsearch!<CR>", {
  noremap = true,
  silent = false,
})
