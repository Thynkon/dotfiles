--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears 		= require("gears")
local lain			= require("lain")
local awful 		= require("awful")
local wibox			= require("wibox")
local dpi			= require("beautiful.xresources").apply_dpi
local beautiful		= require("beautiful")
local wifi_widget	= require("wifi_widget")

local math, string, os = math, string, os
local table = awful.util.table or gears.table -- 4.{0,1} compatibility

--beautiful.bg_systray = "#32D6FF"
local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"
theme.wallpaper                                 = theme.dir .. "/wallpapers/mountain.png"
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
theme.taglist_spacing							= dpi(7)
theme.useless_gap                               = 5

local markup = lain.util.markup
local separators = lain.util.separators

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

    ---- Tags
	-- Dev
	awful.tag.add(
		awful.util.tagnames[1],
		{
			screen = s,
			-- fair layout
			layout = awful.layout.layouts[6]
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
			screen = s,
			layout = awful.layout.layouts[2]
		}
	)

	-- Documents
	awful.tag.add(
		awful.util.tagnames[5],
		{
			screen = s,
			layout = awful.layout.layouts[2]
		}
	)

	-- Gimp
	awful.tag.add(
		awful.util.tagnames[6],
		{
			screen = s,
			layout = awful.layout.layouts[1]
		}
	)

	-- VirtualBox
	awful.tag.add(
		awful.util.tagnames[7],
		{
			screen = s,
			layout = awful.layout.layouts[1]
		}
	)
end

