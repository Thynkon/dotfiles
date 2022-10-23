require("lib/aliases")
-- vim.lsp.set_log_level("DEBUG")

local config_dir = os.getenv("XDG_CONFIG_HOME")
if config_dir == nil then
  config_dir = "~/.config"
end

require("basic")
require("keymap.standard")
if not g.vscode then
  -- require "core"
  require("keymap.telescope")
  require("plugins")

  require("theme/theme")

  -- LSP clients configuration
  require("lsp")

  require("autoload/autocmd")
end
