-- ~/.config/hypr/glove.lua
-- Keypad-style workspace binds for the Glove80 keyboard

local smw = require("plugins.split-monitor-workspaces")

local kp_keys = {
	[1] = "KP_End",
	[2] = "KP_Down",
	[3] = "KP_Next",
	[4] = "KP_Left",
	[5] = "KP_Begin",
}

local mod = "SUPER"

for i, key in pairs(kp_keys) do
	local n = tostring(i)
	hl.bind(mod .. " + " .. key, smw.workspace(n))
	hl.bind(mod .. " + SHIFT + " .. key, smw.move_to_workspace_silent(n))
end
