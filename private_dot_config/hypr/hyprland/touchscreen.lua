hl.config({
	plugin = {
		hyprgrass = {
			sensitivity = 1.0,
			long_press_delay = 400,
			resize_on_border_long_press = true,
			edge_margin = 10,
		},
	},
})

hl.plugin.hyprgrass.bind({
	pattern = { kind = "edge", origin = "d", direction = "l" },
	action = hl.dsp.focus({ workspace = "+1" }),
})

hl.plugin.hyprgrass.bind({
	pattern = { kind = "tap", fingers = 3 },
	action = hl.dsp.window.float(),
})
