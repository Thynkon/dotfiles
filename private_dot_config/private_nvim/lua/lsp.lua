--
local nvim_status = require("lsp-status")
local has_lsp, lspconfig = pcall(require, "lspconfig")
local lsp = {}

if not has_lsp then
	return
end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

opts.desc = "Show diagnostics in a floating window"
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)

opts.desc = "Move to the previous diagnostic in the current buffer"
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

opts.desc = "Move to the next diagnostic"
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

opts.desc = "Add buffer diagnostics to the location list"
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

opts.desc = "Displays hover information about the symbol under the cursor"
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

local fn = vim.fn

fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		timeout_ms = 5000,
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	bufopts.desc = "Jumps to the declaration of the symbol under the cursor"
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)

	bufopts.desc = "Jumps to the definition of the symbol under the cursor"
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

	-- TODO: bufopts.desc = "Jumps to the declaration of the symbol under the cursor"
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

	-- TODO: bufopts.desc = "Jumps to the declaration of the symbol under the cursor"
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

	-- TODO: bufopts.desc = "Jumps to the declaration of the symbol under the cursor"
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

	-- TODO: bufopts.desc = "Jumps to the declaration of the symbol under the cursor"
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)

	-- TODO: bufopts.desc = "Jumps to the declaration of the symbol under the cursor"
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	bufopts.desc = "Jumps to the definition of the type of the symbol under the cursor"
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

	bufopts.desc = "Renames all references to the symbol under the cursor"
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

	bufopts.desc = "Selects a code action available at the current cursor position"
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

	bufopts.desc = "Lists all the references to the symbol under the cursor in the quickfix window"
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	if client.supports_method("textDocument/formatting") then
		print("SUPPORT FORMATTING")
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				print("GOING to FORMAT " .. bufnr)
				lsp_formatting(bufnr)
			end,
		})
	end
end

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
-- updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
updated_capabilities = require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- Code folding
-- updated_capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true
-- }

-- vim.lsp.buf_request(0, "textDocument/codeLens", { textDocument = vim.lsp.util.make_text_document_params() })

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.servers = {
	cmake = (1 == vim.fn.executable("cmake-language-server")),
	bashls = true,
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--suggest-missing-includes",
			"--clang-tidy",
			"--header-insertion=iwyu",
		},
		-- Required for lsp-status
		init_options = {
			clangdFileStatus = true,
		},
		handlers = nvim_status.extensions.clangd.setup(),
	},
	cssls = true,
	denols = true,
	elixirls = {
		cmd = { "elixir-ls" },
	},
	html = true,
	solargraph = true,
	sumneko_lua = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
	gopls = true,
	jsonls = true,
	perlls = true,
	phpactor = true,
	pylsp = true,
	rnix = true,
	rust_analyzer = true,
	sqlls = true,
	texlab = true,
	tailwindcss = true,
	java_language_server = {
		cmd = { "jdt-language-server" },
	},
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = on_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = 50,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(lsp.servers) do
	setup_server(server, config)
end

return lsp
