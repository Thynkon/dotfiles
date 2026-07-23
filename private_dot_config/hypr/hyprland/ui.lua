hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,

		border_size = 2,

		-- https://wiki.hypr.land/Configuring/Basics/Variables/ for color types
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = false,

		-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before turning this on
		allow_tearing = false,

		layout = "nstack", -- plugin layout, see note below
	},

	decoration = {
		rounding = 10,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Custom bezier curve (legacy: bezier = myBezier, 0.05, 0.9, 0.1, 1.05)
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.config({
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
	},
})
