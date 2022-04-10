require("lib/aliases")

local config_dir = os.getenv("XDG_CONFIG_HOME")
if config_dir == nil then
    config_dir = "~/.config"
end

require("basic")
require("keymap.standard")
if api.nvim_eval('!exists("g:vscode")') then
  require("keymap.telescope")
  require("plugins")

  require("theme/theme")

  -- LSP clients configuration
  require("lsp")

  api.nvim_command(string.format("source %s/nvim/autoload/autocmd.vim", config_dir))
end

