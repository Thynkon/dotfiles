-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.user_emmet_leader_key = "<C-Z>"
-- By default timeoutlen is 1000 ms
vim.g.timeoutlen = 500

-- vim.lsp.config("expert", {
--   cmd = { "expert" },
--   root_markers = { "mix.exs", ".git" },
--   filetypes = { "elixir", "eelixir", "heex" },
-- })
--
-- vim.lsp.enable("expert")
