--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"
theme.wallpaper                                 = theme.dir .. "/wallpapers/sun_rise.jpg"
theme.font                                      = "FuraMono Nerd Font Bold 12"
theme.fg_normal                                 = "#FEFEFE"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#1d1f28"
theme.bg_focus                                  = "#414359"
theme.bg_urgent                                 = "#3F3F3F"
theme.bg_systray								= theme.bg_normal
theme.systray_icon_spacing						= dpi(5)
theme.tpngaglist_fg_focus						= "#00CCFF"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#4842ff"
theme.border_marked                             = "#CC9393"
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.screenshot_icon							= theme.dir .. "/icons/screenshot.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_spacing							= dpi(7)
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/charger.png"
theme.widget_brightness                         = theme.dir .. "/icons/brightness.png"
theme.widget_mem                                = theme.dir .. "/icons/ram.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/therm.png"
theme.widget_upload								= theme.dir .. "/icons/upload.png"
theme.widget_download                           = theme.dir .. "/icons/download.png"
theme.widget_vol_muted							= theme.dir .. "/icons/volume_muted.png"
theme.widget_vol_low							= theme.dir .. "/icons/volume_low.png"
theme.widget_vol_normal							= theme.dir .. "/icons/volume_normal.png"
theme.widget_vol_high							= theme.dir .. "/icons/volume_high.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_clock								= theme.dir .. "/icons/clock.png"
theme.widget_calendar							= theme.dir .. "/icons/calendar.png"
theme.useless_gap                               = 5

local markup = lain.util.markup
local separators = lain.util.separators

-- Text clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local calendaricon = wibox.widget.imagebox(theme.widget_calendar)
--local clock = wibox.widget.textclock("%a %d %b %H:%M")
local clock = wibox.widget.textclock("%H:%M")
clock.font = theme.font
local calendar = wibox.widget.textclock("%d.%m.%Y")
calendar.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    --cal = "cal --color=always",
    attach_to = { textclock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Mail IMAP check
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox(theme.widget_mail)
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]
-- PulseAudio volume (based on multicolor theme)
local volumeicon = wibox.widget.imagebox(theme.widget_vol)
local volume = lain.widget.pulse {
	timeout = 0,
    settings = function()
        vlevel = string.format("%s%%", volume_now.left)
        if volume_now.muted == "yes" then
			volumeicon:set_image(theme.widget_vol_muted)
        else
			if not volume_now.left and tonumber(volume_now.left) >= 0 or tonumber(volume_now.left) < 25 then
				volumeicon:set_image(theme.widget_vol_low)
			elseif not volume_now.left and tonumber(volume_now.left) >= 25 or tonumber(volume_now.left) < 75 then
				volumeicon:set_image(theme.widget_vol_normal)
			else
				volumeicon:set_image(theme.widget_vol_high)
			end
        end
        widget:set_markup(markup.font(theme.font, vlevel))
    end
}
-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB"))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "%"))
    end
})

--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]
-- Coretemp (lain, average)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})
--]]
local tempicon = wibox.widget.imagebox(theme.widget_temp)

-- Net
local downloadicon = wibox.widget.imagebox(theme.widget_download)
local download = lain.widget.net({
	timeout = 1,
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
        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE", string.format(" %.1f %sB/s ", net_now.received, unit)))
    end
})

local uploadicon = wibox.widget.imagebox(theme.widget_upload)
local upload = lain.widget.net({
	timeout = 1,
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
        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE", string.format(" %.1f %sB/s ", net_now.sent, unit)))
    end
})

-- Brigtness
local brighticon = wibox.widget.imagebox(theme.widget_brightness)
-- If you use xbacklight, comment the line with "light -G" and uncomment the line bellow
-- local brightwidget = awful.widget.watch('xbacklight -get', 0.1,
local brightwidget = awful.widget.watch('light -G', 0.1,
    function(widget, stdout, stderr, exitreason, exitcode)
        local brightness_level = tonumber(string.format("%.0f", stdout))
        widget:set_markup(markup.font(theme.font, " " .. brightness_level .. "%"))
end)

-- Separators
local arrow = separators.arrow_left

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, dpi(16), dpi(16)), bgcolor, theme.powerline_rl)
end

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
			icon	= theme.dir .. "/icons/dev.png",
			screen	= s,
			-- fairv layout
			layout	= awful.layout.layouts[6]
		}
	)

	-- Firefox
	awful.tag.add(
		awful.util.tagnames[2],
		{
			icon	= theme.dir .. "/icons/web.png",
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

	-- Dolphin
	awful.tag.add(
		awful.util.tagnames[3],
		{
			icon	= theme.dir .. "/icons/file_manager.png",
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

	-- Chat
	awful.tag.add(
		awful.util.tagnames[4],
		{
			icon	= theme.dir .. "/icons/chat.png",
			screen	= s,
			layout	= awful.layout.layouts[2]
		}
	)

	-- Documents
	awful.tag.add(
		awful.util.tagnames[5],
		{
			icon	= theme.dir .. "/icons/document.png",
			screen	= s,
			layout	= awful.layout.layouts[2]
		}
	)

	-- Gimp
	awful.tag.add(
		awful.util.tagnames[6],
		{
			icon	= theme.dir .. "/icons/gimp.png",
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

	-- Gaming
	awful.tag.add(
		awful.util.tagnames[7],
		{
			icon	= theme.dir .. "/icons/gaming.png",
			screen	= s,
			layout	= awful.layout.layouts[1]
		}
	)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create the wibox
    s.topbar = awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })
    s.bottombar = awful.wibar({ position = "bottom", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.taglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),

            wibox.container.background(wibox.container.margin(wibox.widget { mailicon, theme.mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, dpi(4), dpi(7)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { volumeicon, volume.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(3)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { nil, calendaricon, layout = wibox.layout.align.horizontal }, dpi(3), dpi(3)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(calendar, dpi(4), dpi(8)), theme.bgcolor),
            wibox.container.background(wibox.container.margin(wibox.widget { nil, clockicon, layout = wibox.layout.align.horizontal }, dpi(3), dpi(3)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(clock, dpi(4), dpi(8)), theme.bgcolor),
            --]]
            s.mylayoutbox,
        },
    }
    s.bottombar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            wibox.container.background(wibox.container.margin(wibox.widget { nil, downloadicon, download.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(3)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { nil, uploadicon, upload.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(3)), theme.bg_normal),
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            wibox.container.background(wibox.container.margin(wibox.widget { mailicon, theme.mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, dpi(4), dpi(7)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, dpi(2), dpi(3)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(4)), theme.bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, dpi(4), dpi(4)), theme.bg_normal)
        },
    }
end

return theme
