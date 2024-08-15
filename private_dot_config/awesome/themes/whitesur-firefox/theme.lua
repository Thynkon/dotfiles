--[[

     Holo Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local markup = lain.util.markup
local os = os
local debug = debug

local theme = {}
theme.name = "whitesur-firefox"
theme.directory = debug.getinfo(2, "S").source:sub(2):match("(.*/)")
theme.default_dir = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir = string.format("%s/.config/awesome/themes/%s/icons", os.getenv("HOME"), theme.name)
theme.wallpaper = string.format("%s/.config/awesome/themes/%s/wallpapers/minimalist.png", os.getenv("HOME"), theme.name)
theme.separator = theme.icon_dir .. "/seperator.png"

theme.font_size = 12
theme.font = string.format("MesloLGS NF %d", theme.font_size)
theme.font_color = "#1C1E20"

theme.bg_normal = "#181825" --"#263238"
theme.bg_focus = "#C4C7C5"
theme.bg_urgent = "#55707d"
theme.fg_normal = "#C4C7C5"
theme.fg_focus = theme.bg_normal
theme.fg_urgent = theme.font_color

theme.tag_bg_normal = "#1e1e2e"

-- borders
theme.border_width = dpi(3)
theme.border_normal = "#252525"
theme.border_focus = "#0099CC"
theme.useless_gap = dpi(4)

theme.hotkeys_shape = gears.shape.rounded_rect
theme.hotkeys_border_width = dpi(2)

-- icons
theme.icon_widget_width = dpi(30)
theme.font_icons = "MesloLGS NF"
-- battery
theme.battery_icon_bg = "#eC6798"
theme.battery_font_size = 20
theme.battery_font_size = theme.battery_font_size - 10
theme.battery_ac = ""
theme.battery_low = ""
theme.battery_half = ""
theme.battery_good = ""
theme.battery_full = ""

-- clock
theme.clock_icon = ""
theme.clock_icon_bg = "#f8e1ae"
theme.clock_font_size = theme.font_size

-- cpu
theme.cpu_icon = ""
theme.cpu_icon_bg = "#93e1d4"
theme.cpu_font_size = theme.font_size

-- network
-- download
theme.download_icon = ""
theme.download_icon_bg = "#5CBD61"
theme.network_font_size = theme.font_size
-- upload
theme.upload_icon = ""
theme.upload_icon_bg = theme.download_icon_bg

-- layoutbox
theme.layout_tile = theme.icon_dir .. "/tile.png"
theme.layout_tileleft = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv = theme.icon_dir .. "/fairv.png"
theme.layout_fairh = theme.icon_dir .. "/fairh.png"
theme.layout_spiral = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle = theme.icon_dir .. "/dwindle.png"
theme.layout_max = theme.icon_dir .. "/max.png"
theme.layout_fullscreen = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier = theme.icon_dir .. "/magnifier.png"
theme.layout_floating = theme.icon_dir .. "/floating.png"

-- memory
theme.memory_icon = ""
theme.memory_icon_bg = "#f9b286"
theme.memory_font_size = theme.font_size

-- taglist
theme.taglist_font = "MesloLGS NF 15"
theme.taglist_font_color = "#cdd6f4"

theme.taglist_bg_focus = theme.taglist_font_color
theme.taglist_fg_focus = theme.font_color

theme.taglist_bg_normal = "#1e1e2e"
theme.taglist_fg_normal = theme.taglist_font_color

theme.taglist_bg_empty = theme.taglist_bg_normal
theme.taglist_fg_empty = theme.taglist_font_color

theme.taglist_bg_occupied = theme.taglist_bg_normal
theme.taglist_fg_occupied = theme.taglist_font_color

theme.taglist_squares_sel = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel = theme.icon_dir .. "/square_unsel.png"

theme.taglist_spacing = dpi(5)

-- tasklist
theme.tasklist_bg_normal = theme.font_color
theme.tasklist_fg_focus = theme.bg_normal
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true

-- temperature
theme.temperature_very_low = ""
theme.temperature_low = ""
theme.temperature_normal = ""
theme.temperature_high = ""
theme.temperature_very_high = ""
theme.temperature_icon_bg = "#f38ba8"
theme.temperature_font_size = theme.font_size

-- volume
theme.volume_icon_bg = "#6994b9"
theme.volume_font_size = theme.font_size
theme.volume_muted = "婢"
theme.volume_low = "奄"
theme.volume_normal = "奔"
theme.volume_loud = "墳"

local separator = wibox.widget.imagebox(theme.separator)
-- Battery
local battery_icon = wibox.widget.textbox()
battery_icon.forced_width = theme.icon_widget_width
battery_icon.align = "center"
battery_icon:set_markup(
	markup.fontfg(
		string.format("%s %d", theme.font_icons, theme.battery_font_size),
		theme.font_color,
		battery_icon.text
	)
)
local battery_icon_bg = wibox.container.background(battery_icon, theme.battery_icon_bg, gears.shape.rectangle)
local battery_icon_widget = wibox.container.margin(battery_icon_bg, dpi(0), dpi(0), dpi(5), dpi(5))

local battery = lain.widget.bat({
	timeout = 1,
	settings = function()
		local icon = ""
		if bat_now.status and bat_now.status ~= "N/A" then
			if bat_now.ac_status == 1 then
				widget:set_markup(
					markup.fontfg(
						string.format("%s %d", theme.font_icons, theme.battery_font_size),
						theme.font_color,
						" AC "
					)
				)
				battery_icon:set_markup(
					markup.fontfg(
						string.format("%s %d", theme.font_icons, theme.battery_font_size),
						theme.font_color,
						theme.battery_ac
					)
				)
				return
			elseif not bat_now.perc and tonumber(bat_now.perc) > 0 or tonumber(bat_now.perc) <= 25 then
				icon = theme.battery_low
			elseif not bat_now.perc and tonumber(bat_now.perc) > 25 or tonumber(bat_now.perc) <= 50 then
				icon = theme.battery_half
			elseif not bat_now.perc and tonumber(bat_now.perc) > 50 or tonumber(bat_now.perc) <= 75 then
				icon = theme.battery_good
			else
				icon = theme.battery_full
			end
			battery_icon:set_markup(
				markup.fontfg(string.format("%s %d", theme.font_icons, theme.battery_font_size), theme.font_color, icon)
			)
			widget:set_markup(
				markup.fontfg(
					string.format("%s %d", theme.font_icons, theme.battery_font_size),
					theme.font_color,
					string.format(" %s%% ", bat_now.perc)
				)
			)
		else
			battery_icon:set_markup(
				markup.fontfg(
					string.format("%s %d", theme.font_icons, theme.battery_font_size),
					theme.font_color,
					theme.battery_ac
				)
			)
			widget:set_markup(
				markup.fontfg(
					string.format("%s %d", theme.font_icons, theme.battery_font_size),
					theme.font_color,
					" AC "
				)
			)
		end
	end,
})
battery.align = "center"
local battery_bg = wibox.container.background(battery.widget, theme.bg_focus, gears.shape.rectangle)
local battery_widget = wibox.container.margin(battery_bg, dpi(0), dpi(0), dpi(5), dpi(5))

-- if I don't use Pango markup, the widget will use "theme.fg_normal"
-- when it updates it's value
local clock = wibox.widget.textclock(
	string.format(
		'<span font="%s %d" foreground="%s"> %s %%H:%%M </span>',
		theme.font_icons,
		theme.clock_font_size,
		theme.font_color,
		theme.clock_icon
	)
)
local clock_widget = wibox.container.background({
	widget = wibox.container.background(clock, theme.clock_icon_bg),
	shape = gears.shape.rounded_rect,
})

-- cpu
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(
			markup.fontfg(
				string.format("%s %d", theme.font_icons, theme.cpu_font_size),
				theme.font_color,
				string.format(" %s %d%% ", theme.cpu_icon, cpu_now.usage)
			)
		)
	end,
})
local cpu_widget = wibox.container.background({
	widget = wibox.container.background(cpu.widget, theme.cpu_icon_bg),
	shape = gears.shape.rounded_rect,
})

-- download
local download = lain.widget.net({
	settings = function()
		local unit = "K"

		-- 1 024 KB = 1 MB
		-- 1 048 576 KB = 1GB
		if tonumber(net_now.received) >= 1024 and tonumber(net_now.received) < 1048576 then
			unit = "M"
			net_now.received = net_now.received / 1024
		elseif tonumber(net_now.received) >= 1048576 then
			unit = "G"
			net_now.received = net_now.received / (1024 * 2)
		end

		widget:set_markup(markup.font(theme.font, string.format(" %.1f%sB/s ", net_now.received, unit)))
		widget:set_markup(
			markup.fontfg(
				string.format("%s %d", theme.font_icons, theme.network_font_size),
				theme.font_color,
				string.format(" %s %.1f%sB/s ", theme.download_icon, net_now.received, unit)
			)
		)
	end,
})

-- upload
local upload = lain.widget.net({
	settings = function()
		local unit = "K"

		-- 1 024 KB = 1 MB
		-- 1 048 576 KB = 1GB
		if tonumber(net_now.sent) >= 1024 and tonumber(net_now.sent) < 1048576 then
			unit = "M"
			net_now.sent = net_now.sent / 1024
		elseif tonumber(net_now.sent) >= 1048576 then
			unit = "G"
			net_now.sent = net_now.sent / (1024 * 2)
		end

		widget:set_markup(
			markup.fontfg(
				string.format("%s %d", theme.font_icons, theme.network_font_size),
				theme.font_color,
				string.format(" %s %.1f%sB/s ", theme.upload_icon, net_now.sent, unit)
			)
		)
	end,
})
local network_widget = wibox.container.background({
	widget = wibox.container.background(
		wibox.widget({
			download,
			upload,
			layout = wibox.layout.align.horizontal,
		}),
		theme.download_icon_bg
	),
	shape = gears.shape.rounded_rect,
})

local memory = lain.widget.mem({
	settings = function()
		local unit = "MB"

		widget:set_markup(
			markup.fontfg(
				string.format("%s %d", theme.font_icons, theme.memory_font_size),
				theme.font_color,
				string.format(" %s %d%s ", theme.memory_icon, mem_now.used, unit)
			)
		)
	end,
})
local memory_widget = wibox.container.background({
	widget = wibox.container.background(memory.widget, theme.memory_icon_bg),
	shape = gears.shape.rounded_rect,
})

-- temperature
local temperature = lain.widget.temp({
	settings = function()
		widget:set_markup(
			markup.fontfg(
				string.format("%s %d", theme.font_icons, theme.temperature_font_size),
				theme.font_color,
				string.format(" %s %s°C ", theme.temperature_normal, coretemp_now)
			)
		)
	end,
})
local temperature_widget = wibox.container.background({
	widget = wibox.container.background(temperature.widget, theme.temperature_icon_bg),
	shape = gears.shape.rounded_rect,
})

-- Volume
local volume_icon = wibox.widget.textbox()
volume_icon.forced_width = theme.icon_widget_width
volume_icon.align = "center"
volume_icon:set_markup(
	markup.fontfg(string.format("%s %d", theme.font_icons, theme.volume_font_size), theme.font_color, volume_icon.text)
)
theme.volume = lain.widget.alsa({
	timeout = 1,
	settings = function()
		local icon = ""
		local volume = ""

		if volume_now.status == "on" then
			if not volume_now.level and tonumber(volume_now.level) > 0 or tonumber(volume_now.level) <= 33 then
				icon = theme.volume_low
			elseif not volume_now.level and tonumber(volume_now.level) > 33 or tonumber(volume_now.level) <= 66 then
				icon = theme.volume_normal
			else
				icon = theme.volume_loud
			end
			volume = string.format("%d%%", volume_now.level)
		else
			volume = "Muted"
			icon = theme.volume_muted
		end
		widget:set_markup(
			markup.fontfg(
				string.format("%s %d", theme.font_icons, theme.volume_font_size),
				theme.font_color,
				string.format(" %s %s ", icon, volume)
			)
		)
		-- each time volume_icon's text is changed, it's font also changes
		volume_icon:set_markup(
			markup.fontfg(string.format("%s %d", theme.font_icons, theme.volume_font_size), theme.font_color, icon)
		)
	end,
})
theme.volume.align = "center"
local volume_widget = wibox.container.background({
	widget = wibox.container.background(theme.volume.widget, theme.volume_icon_bg),
	shape = gears.shape.rounded_rect,
})

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })

	-- If wallpaper is a function, call it with the screen
	local wallpaper = theme.wallpaper
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end
	gears.wallpaper.maximized(wallpaper, s, true)

	-- Tags
	-- Dev
	awful.tag.add(awful.util.tagnames[1], {
		screen = s,
		-- fairv layout
		layout = awful.layout.layouts[6],
	})

	-- Firefox
	awful.tag.add(awful.util.tagnames[2], {
		screen = s,
		layout = awful.layout.layouts[2],
	})

	-- Dolphin
	awful.tag.add(awful.util.tagnames[3], {
		screen = s,
		layout = awful.layout.layouts[2],
	})

	-- Chat
	awful.tag.add(awful.util.tagnames[4], {
		screen = s,
		layout = awful.layout.layouts[2],
	})

	-- Documents
	awful.tag.add(awful.util.tagnames[5], {
		screen = s,
		layout = awful.layout.layouts[2],
	})

	-- Gaming
	awful.tag.add(awful.util.tagnames[6], {
		screen = s,
		layout = awful.layout.layouts[1],
	})

	-- Create a promptbox for each screen
	s.promptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.layoutbox = awful.widget.layoutbox(s)

	-- Create a taglist widget
	s.taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 5)
			end,
		},
		buttons = awful.util.taglist_buttons,
	})

	s.tag = wibox.container.margin(s.taglist, dpi(0), dpi(0), dpi(5), dpi(5))
	-- Create a tasklist widget
	s.tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, {
		bg_focus = theme.tag_bg_focus,
		shape = gears.shape.rounded_rect,
		-- shape_border_width = 5,
		shape_border_color = theme.bg_normal,
		align = "center",
	})

	-- Create the wibox
	s.topwibox = awful.wibar({ position = "top", screen = s, height = dpi(32) })

	-- Add widgets to the wibox
	s.topwibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			separator,
			s.tag,
			separator,
			s.promptbox,
		},
		nil, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray({ visible = true }),
			separator,
			battery_icon_widget,
			battery_widget,
			separator,
			volume_widget,
			separator,
			clock_widget,
			separator,
			s.layoutbox,
			separator,
		},
	})

	-- Create the bottom wibox
	s.bottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = dpi(0), height = dpi(32) })

	-- Add widgets to the bottom wibox
	s.bottomwibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			separator,
			network_widget,
			separator,
		},
		s.tasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			separator,
			memory_widget,
			separator,
			cpu_widget,
			separator,
			temperature_widget,
			separator,
		},
	})
end

return theme
