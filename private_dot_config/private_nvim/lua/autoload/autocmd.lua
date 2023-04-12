require("lib.aliases")

local a = require("lib/autocmd")

a.c({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.diagnostic.open_float()
	end,
})

a.c({ "CursorHold", "CursorHoldI" }, {
	pattern = { "*.html", "*.css" },
	command = "EmmetInstall",
})

a.g("YankHighlight", { clear = true })
a.c({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank()
	end,
})

a.c({ "User" }, {
	pattern = "GitConflictDetected",
	callback = function()
		vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
		vim.keymap.set("n", "cww", function()
			engage.conflict_buster()
			create_buffer_local_mappings()
		end)
	end,
})
