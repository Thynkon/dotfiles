require("lib/aliases")
-- vim.lsp.set_log_level("DEBUG")

local config_dir = os.getenv("XDG_CONFIG_HOME")
if config_dir == nil then
    config_dir = "~/.config"
end

local startup_modules = {"basic" -- "keymap.standard"
}

if not g.vscode then
    require("config.lazy")
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            require "keymap.telescope"
            require "keymap.standard"
        end
    })
    -- table.insert(startup_modules, "keymap.telescope")
    table.insert(startup_modules, "plugins")
    table.insert(startup_modules, "theme/theme")
    table.insert(startup_modules, "lsp")
    table.insert(startup_modules, "autoload/autocmd")
end

for _, source in ipairs(startup_modules) do
    local status_ok, fault = pcall(require, source)
    if not status_ok then
        vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
    end
end
