--[[

     Holo Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")

local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/holo/wallpapers/minimalist.png"
theme.font                                      = "Roboto Bold 10"
theme.taglist_font                              = theme.font
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#0099CC"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#006B8E"
theme.border_width                              = dpi(3)
theme.border_normal                             = "#252525"
theme.border_focus                              = "#0099CC"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.tasklist_bg_normal                        = "#222222"
theme.tasklist_fg_focus                         = "#4CB7DB"
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(160)
theme.menu_icon_size                            = dpi(32)
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
theme.bar                                       = theme.icon_dir .. "/bar.png"
theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.calendar                                  = theme.icon_dir .. "/cal.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(4)

local markup = lain.util.markup
local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local textclock = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%H:%M" .. markup.font("Roboto 4", " ")))
local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(textclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Calendar
local textcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(textcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, dpi(0), dpi(0), dpi(5), dpi(5))
theme.cal = lain.widget.cal({
    notification_preset = {
        fg = "#FFFFFF",
        bg = theme.bg_normal,
        position = "bottom_right",
        font = "Monospace 10"
    }
})

-- / fs
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { bg = theme.bg_normal, font = "Monospace 9" },
})
--]]

-- Volume
theme.volume = lain.widget.alsabar({
	timeout = 1,
    notification_preset = { font = "Monospace 9"},
    --togglechannel = "IEC958,3",
    width = dpi(80), height = dpi(10), border_width = dpi(0),
    colors = {
        background = "#383838",
        unmute     = "#80CCE6",
        mute       = "#FF9F9F"
    },
})
theme.volume.bar.paddings = dpi(0)
theme.volume.bar.margins = dpi(5)
local volumewidget = wibox.container.background(theme.volume.bar, theme.bg_focus, gears.shape.rectangle)
volumewidget = wibox.container.margin(volumewidget, dpi(0), dpi(0), dpi(5), dpi(5))

local volume_text = lain.widget.alsa({
	timeout = 1,
	settings = function() 
		local string = ""

		if volume_now.status == "on" then
			string = string.format("%d%% ", volume_now.level)
		else
			string = "Muted"
		end
			widget:set_markup(markup.font(theme.font, string))
	end
})
local volume_textbg = wibox.container.background(volume_text.widget, theme.bg_focus, gears.shape.rectangle)
local volume_textwidget = wibox.container.margin(volume_textbg, dpi(0), dpi(0), dpi(5), dpi(5))

local mem = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.font(theme.font, "RAM " .. mem_now.used .. "MB"))
	end
})
local membg = wibox.container.background(mem.widget, theme.bg_focus, gears.shape.rectangle)
local memwidget = wibox.container.margin(membg, dpi(0), dpi(0), dpi(5), dpi(5))

local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(space3 .. markup.font(theme.font, "CPU " .. cpu_now.usage
                          .. "% ") .. markup.font("Roboto 5", " "))
    end
})
local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, dpi(0), dpi(0), dpi(5), dpi(5))

-- TEMP
local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.font(theme.font, "TEMP " .. coretemp_now .. "°C "))
	end
})
local tempbg = wibox.container.background(temp.widget, theme.bg_focus, gears.shape.rectangle)
local tempwidget = wibox.container.margin(tempbg, dpi(0), dpi(0), dpi(5), dpi(5))
 --]]

-- Net
local netdown_icon = wibox.widget.imagebox(theme.net_down)
local netup_icon = wibox.widget.imagebox(theme.net_up)
local net = lain.widget.net({
    settings = function()
		local download_unit = "K"
		local upload_unit = "K"

		-- 1 024 KB = 1 MB
		-- 1 048 576 KB = 1GB
		if tonumber(net_now.received) >= 1024 and tonumber(net_now.received) < 1048576 then
			download_unit = "M"
			net_now.received = net_now.received / 1024
		elseif tonumber(net_now.received) >= 1048576 then
			download_unit = "G"
			net_now.received = net_now.received / (1024 * 2)
		end

		if tonumber(net_now.sent) >= 1024 and tonumber(net_now.sent) < 1048576 then
			upload_unit = "M"
			net_now.sent = net_now.sent / 1024
		elseif tonumber(net_now.received) >= 1048576 then
			upload_unit = "G"
			net_now.sent = net_now.sent / (1024 * 2)
		end

		widget:set_markup(markup.font("Roboto 1", " ") .. markup.font(theme.font, string.format(" %.1f %sB/s - %.1f %sB/s ",
			net_now.received, download_unit, net_now.sent, upload_unit)) .. markup.font("Roboto 2", " "))
    end
})
local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)

local barcolor  = gears.color({
    type  = "linear",
    from  = { dpi(32), 0 },
    to    = { dpi(32), dpi(32) },
    stops = { {0, theme.bg_focus}, {0.25, "#505050"}, {1, theme.bg_focus} }
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
	awful.tag.add(
		awful.util.tagnames[1],
		{
			screen	= s,
			-- fairv layout
			layout	= awful.layout.layouts[6]
		}
	)

	-- Firefox
	awful.tag.add(
		awful.util.tagnames[2],
		{
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

	-- Dolphin
	awful.tag.add(
		awful.util.tagnames[3],
		{
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

	-- Chat
	awful.tag.add(
		awful.util.tagnames[4],
		{
			screen	= s,
			layout	= awful.layout.layouts[2]
		}
	)

	-- Documents
	awful.tag.add(
		awful.util.tagnames[5],
		{
			screen	= s,
			layout	= awful.layout.layouts[2]
		}
	)

	-- Gimp
	awful.tag.add(
		awful.util.tagnames[6],
		{
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

	-- Gaming
	awful.tag.add(
		awful.util.tagnames[7],
		{
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = barcolor })

    taglistcont = wibox.container.background(s.taglist, theme.bg_focus, gears.shape.rectangle)
    s.tag = wibox.container.margin(taglistcont, dpi(0), dpi(0), dpi(5), dpi(5))

    -- Create a tasklist widget
    s.tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { bg_focus = theme.bg_focus, shape = gears.shape.rectangle, shape_border_width = 5, shape_border_color = theme.tasklist_bg_normal, align = "center" })

    -- Create the wibox
    s.topwibox = awful.wibar({ position = "top", screen = s, height = dpi(32) })

    -- Add widgets to the wibox
    s.topwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.tag,
            s.promptbox,
        },
		nill, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
			bar,
            volumewidget,
			volume_textwidget,
			bar,
            calendar_icon,
            calendarwidget,
            bar,
            clock_icon,
            clockwidget,
            bar,
            s.layoutbox,
        },
    }

    -- Create the bottom wibox
    s.bottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = dpi(0), height = dpi(32) })
    s.borderwibox = awful.wibar({ position = "bottom", screen = s, height = dpi(1), bg = theme.fg_focus, x = dpi(0), y = dpi(33)})

    -- Add widgets to the bottom wibox
    s.bottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            netdown_icon,
            networkwidget,
            netup_icon,
        },
        s.tasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr_bottom_right,
			memwidget,
            bottom_bar,
            cpuwidget,
            bottom_bar,
			tempwidget,
        },
    }
end

return theme
