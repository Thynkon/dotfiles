local config = require("hyprland/config")

hl.bind(config.mainMod .. " + RETURN", hl.dsp.exec_cmd(config.terminal))
hl.bind(config.mainMod .. " + C", hl.dsp.window.close())
hl.bind(config.mainMod .. " + M", hl.dsp.exit())
hl.bind(config.mainMod .. " + e", hl.dsp.exec_cmd(config.file_manager))
hl.bind("SUPER + CONTROL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(config.mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(config.mainMod .. " + D", hl.dsp.exec_cmd(config.menu))
hl.bind(config.mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + SPACE", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(config.mainMod .. " + j", hl.dsp.focus({ direction = "left" }))
hl.bind(config.mainMod .. " + eacute", hl.dsp.focus({ direction = "right" }))
hl.bind(config.mainMod .. " + l", hl.dsp.focus({ direction = "up" }))
hl.bind(config.mainMod .. " + k", hl.dsp.focus({ direction = "down" }))

-- Applications
hl.bind(config.mainMod .. " + w", hl.dsp.exec_cmd("zen-browser"))
hl.bind(config.mainMod .. " + Y", hl.dsp.exec_cmd("$HOME/.local/bin/udiskie-dmenu"))

-- Toggle control center
hl.bind(config.mainMod .. " + SHIFT + n", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty --filename -'))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Media
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("SUPER + Tab", hl.dsp.window.cycle_next())

--------------------------------
---- WORKSPACES / MONITORS ----
--------------------------------

local smw = require("plugins.split-monitor-workspaces")

for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then
		n = "0" -- workspace 10 is bound to the "0" key
	end
	hl.bind(config.mainMod .. " +" .. n, smw.workspace(n))
	hl.bind(config.mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

-- Special workspace (scratchpad)
hl.bind(config.mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(config.mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(config.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(config.mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- resize
hl.bind(config.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(config.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Lid switch
hl.bind("switch:[screenlock]", hl.dsp.exec_cmd("hyprlock"), { locked = true })
hl.bind("switch:on:[screenlock]", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'), { locked = true })
hl.bind(
	"switch:off:[screenlock]",
	hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, 1920x1200, 0x0, 1"'),
	{ locked = true }
)

-- Swap with master (layout master)
hl.bind(config.mainMod .. " + space", hl.dsp.layout("swapwithmaster master"))

-- Fullscreen
hl.bind(config.mainMod .. " + f", hl.dsp.window.fullscreen())
