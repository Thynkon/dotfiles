local key = require("lib/keybindings")
local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7") == 1,
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position. It can be an Int
	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "□",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
})

local opts = { noremap = true, silent = true }
opts.desc = "Toggle debugger UI"
key.map("n", "<leader>db", dapui.toggle, opts)

opts.desc = "Launch debugger/continue"
key.map("n", "<F5>", dap.continue, opts)

opts.desc = "Step over"
key.map("n", "<F10>", dap.step_over, opts)

opts.desc = "Step into"
key.map("n", "<F11>", dap.step_into, opts)

opts.desc = "Step out"
key.map("n", "<F12>", dap.step_out, opts)

opts.desc = "Toggle breakpoint"
key.map("n", "<leader>b", dap.toggle_breakpoint, opts)
-- key.map("n", "<leader>B", dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")), {noremap = true, silent = true})
-- key.map(
--   "n",
--   "<leader>lp",
--   dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")),
--   {noremap = true, silent = true}
-- )
key.map("n", "<leader>dr", dap.repl.open, { noremap = true, silent = true })
key.map("n", "<leader>dl", dap.run_last, { noremap = true, silent = true })
