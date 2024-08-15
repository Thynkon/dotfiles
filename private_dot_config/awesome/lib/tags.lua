local awful = require("awful")
local settings = require("lib.settings")
local lain = require("lain")
local dpi = require("beautiful.xresources").apply_dpi

local tags = {
	terminal = settings.terminal,
	tagnames = { 1, 2, 3, 4, 5, 6 },
	-- awful.layout.suit.tile.left.mirror = true,
	layouts = {
		awful.layout.suit.tile,
		awful.layout.suit.floating,
		awful.layout.suit.tile.left,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.top,
		awful.layout.suit.fair,
		--awful.layout.suit.fair.horizontal,
		--awful.layout.suit.spiral,
		--awful.layout.suit.spiral.dwindle,
		awful.layout.suit.max,
		--awful.layout.suit.max.fullscreen,
		awful.layout.suit.magnifier,
		--awful.layout.suit.corner.nw,
		--awful.layout.suit.corner.ne,
		--awful.layout.suit.corner.sw,
		--awful.layout.suit.corner.se,
		--lain.layout.cascade,
		--lain.layout.cascade.tile,
		--lain.layout.centerwork,
		--lain.layout.centerwork.horizontal,
		--lain.layout.termfair,
		--lain.layout.termfair.center,
	},

	termfair = {
		nmaster = 3,
		ncol = 1,
		center = {
			nmaster = 3,
			ncol = 1,
		},
	},
	cascade = {
		tile = {
			offset_x = dpi(2),
			offset_y = dpi(32),
			extra_padding = dpi(5),
			nmaster = 5,
			ncol = 2,
		},
	},
}

return tags
