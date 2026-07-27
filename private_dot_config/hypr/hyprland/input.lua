---------------
---- INPUT ----
---------------

local touch_screen = "eDP-1" -- $touch_screen was undefined in your snippet, adjust

hl.config({
	input = {
		kb_layout = "ch",
		kb_variant = "fr",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},

		touchdevice = {
			enabled = true,
			output = touch_screen,
		},

		-- needed to make screen calibration work
		tablet = {
			output = touch_screen,
		},

		numlock_by_default = true,
	},

	gestures = {
		-- workspace_swipe = true,
		workspace_swipe_cancel_ratio = 0.15,
	},

	cursor = {
		no_hardware_cursors = true,
	},
})

hl.config({
	input = {
		kb_layout = "ch,optimot",
		kb_variant = "fr,",
		kb_options = "grp:alt_shift_toggle",
	},
})

hl.device({
	name = "glove80-keyboard",
	kb_layout = "optimot",
	kb_variant = "",
	numlock_by_default = true,
	resolve_binds_by_sym = true,
})
