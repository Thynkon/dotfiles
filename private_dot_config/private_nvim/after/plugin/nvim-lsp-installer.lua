local lsp_installer = require("nvim-lsp-installer")
local ok, server = nil, nil

-- I should use the table declared in lsp.lua
-- but I do not know yet how to get table's keys in lua.
-- This is an horrible solution, but at least it works :)
local servers = {
        'bashls',
        'clangd',
        'cmake',
        'cssls',
        'denols',
        'gopls',
        'html',
        'jsonls',
        'phpactor',
        'rnix',
--        'rust_analyzer',
        'sqlls',
        'sumneko_lua',
        'texlab',
}

for _, server_name in pairs(servers) do
        ok, server = lsp_installer.get_server(server_name)
        if ok then
                if not server:is_installed() then
                        server:install()
                end
        end
end
