--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

local awesome, client, screen = awesome, client, screen
local ipairs, string, os, tostring = ipairs, string, os, tostring

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain          = require("lain")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local table         = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

-- }}}

-- {{{ Variable definitions
local rofi_config = string.format("%s/.config/rofi", os.getenv("HOME"))

local themes = {
    "no-wibar",
    "holo",
    "theme8",
}

-- choose your theme here
local chosen_theme = themes[3]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

local modkey    = "Mod1"
local superkey  = "Mod4"
local ctrlkey   = "Control"

-- personal variables
--change these variables if you want
local browser               = "firefox-developer"
local editorgui             = string.format("codium --extensions-dir='%s/.local/share/VSCodium/extensions'", os.getenv("HOME"))
local filemanager           = "dolphin"
local mailclient            = "thunderbird"
local imageeditor           = "gimp"
local terminal              = "alacritty"
local virtualmachine        = "virtualbox"
local screenshotutility     = "spectacle"
local desktopenvironment    = "KDE"
local volume_step           = 5
local brightness_step       = 10
local bar                   = "wibar"

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = { "  ", " 爵 ", "  ", "  ", "  ", "  ", "  " }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
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
}

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
    function(s) beautiful.at_screen_connect(s)
--      s.systray = wibox.widget.systray()
--      s.systray.visible = true
    end
)
-- }}}

-- {{{ Mouse bindings
root.buttons(table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = table.join(
    -- awesome
    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.topwibox.visible = not s.topwibox.visible
                if s.bottomwibox then
                    s.bottomwibox.visible = not s.bottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description = "show help", group="awesome"}),
     -- Show/Hide Systray
    awful.key({ modkey }, "KP_Subtract",
        function ()
            awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
        end,
        {description = "Toggle systray visibility", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ superkey }, "x",
        function ()
            awful.prompt.run {
              prompt       = "Run Lua code: ",
              textbox      = awful.screen.focused().promptbox.widget,
              exe_callback = awful.util.eval,
              history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}),

    -- launcher
    awful.key({ modkey }, "Return",
        function () awful.spawn(terminal) end,
        {description = terminal, group = "launcher"}),
    awful.key({ modkey, "Shift"}, "h",
        function () awful.spawn( string.format("%s -t 'htop task manager' -e htop", terminal)) end,
        {description = "htop", group = "launcher"}),
    awful.key({ modkey }, "r",
        function () awful.spawn( "rofi-theme-selector" ) end,
        {description = "rofi theme selector", group = "launcher"}),
    awful.key({ modkey }, "v",
        function () awful.spawn( "pavucontrol" ) end,
        {description = "pulseaudio control", group = "launcher"}),
    awful.key({ modkey }, "w",
        function () awful.spawn( browser ) end,
        {description = browser, group = "launcher"}),
    awful.key({ modkey, "Shift" },"e",
        function () awful.spawn( editorgui ) end,
        {description = editorgui , group = "launcher" }),
    awful.key({ modkey }, "F3",
        function () awful.spawn( "inkscape" ) end,
        {description = "inkscape", group = "launcher" }),
    awful.key({ modkey }, "g",
        function () awful.spawn( imageeditor ) end,
        {description = imageeditor , group = "launcher" }),
    awful.key({ modkey }, "F6",
        function () awful.spawn( "vlc --video-on-top" ) end,
        {description = "vlc" , group = "launcher" }),
    awful.key({ modkey }, "F7",
        function () awful.spawn( "virtualbox" ) end,
        {description = virtualmachine , group = "launcher" }),
    awful.key({ modkey }, "e",
        function () awful.spawn( filemanager ) end,
        {description = filemanager , group = "launcher" }),
    awful.key({ modkey }, "F9",
        function () awful.spawn( mailclient ) end,
        {description = mailclient , group = "launcher"}),
    awful.key({ modkey }, "d",
        function () awful.spawn(string.format("%s/bin/app_launcher.sh", rofi_config)) end,
        {description = "rofi" , group = "launcher" }),
    awful.key({ modkey }, "y",
        function () awful.spawn(string.format("%s/.local/bin/udiskie-dmenu", os.getenv("HOME"))) end,
        {description = "Device manager", group = "launcher"}),

    -- super + ...
    awful.key({ modkey }, "u",
        function () awful.screen.focused().promptbox:run() end,
          {description = "run prompt", group = "super"}),
    awful.key({ modkey }, "x",
        function () awful.spawn( "oblogout" ) end,
      {description = "exit", group = "hotkeys"}),
    awful.key({ modkey }, "Escape",
        function () awful.spawn( "xkill" ) end,
        {description = "Kill proces", group = "hotkeys"}),

    -- ctrl+alt +  ...
    awful.key({ ctrlkey, superkey   }, "c", function() awful.spawn("catfish") end,
        {description = "catfish", group = "alt+ctrl"}),
    awful.key({ ctrlkey, superkey   }, "o",
        function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/compton-toggle.sh") end,
        {description = "Compton toggle", group = "alt+ctrl"}),
    awful.key({ ctrlkey, superkey   }, "m",
        function() awful.spawn("systemsettings5") end,
        {description = string.format("%s settings manager", desktopenvironment), group = "alt+ctrl"}),
    awful.key({ ctrlkey, superkey   }, "p",
        function() awful.spawn( "plasma-discover" ) end,
        {description = string.format("%s store", desktopenvironment), group = "alt+ctrl"}),
    -- screenshots
    awful.key({ }, "Print",
        function () awful.spawn(screenshotutility) end,
        {description = "KDE screenshot", group = "screenshots"}),

    -- Default client focus
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.bydirection("down")
        end,
        {description = "Focus down", group = "client"}
    ),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.bydirection("up")
        end,
        {description = "Focus up", group = "client"}
    ),
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("left")
        end,
        {description = "Focus left", group = "client"}),
    awful.key({ modkey }, "é",
        function()
            awful.client.focus.global_bydirection("right")
        end,
        {description = "Focus right", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "é", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Tag
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),
    -- On the fly useless gaps change
    awful.key({ modkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ modkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),
    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- layout
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp",
        function ()
            os.execute(string.format("xbacklight -inc %d", brightness_step))
        end,
        {description = string.format("+%d%%", brightness_step), group = "hotkeys"}),

    awful.key({ }, "XF86MonBrightnessDown",
        function ()
            os.execute(string.format("xbacklight -dec %d", brightness_step))
        end,
        {description = string.format("-%d%%", brightness_step), group = "hotkeys"}),

    -- volume
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s %d%%+", beautiful.volume.channel, volume_step))
            beautiful.volume.update()
        end,
        {description = string.format("+%d%%", volume_step), group = "audio"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s %d%%-", beautiful.volume.channel, volume_step))
            beautiful.volume.update()
        end,
        {description = string.format("-%d%%", volume_step), group = "audio"}),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "Mute volume", group = "audio"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ ctrlkey, "Shift" }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),

    awful.key({ modkey, "Shift" }, "q",
        function () awful.spawn(string.format("%s/bin/menu_powermenu.sh", rofi_config)) end,
        {description = "Logout with confirmation", group = "kde"}),
    awful.key({ ctrlkey, superkey   }, "k",
        function() os.execute("loginctl lock-session") end,
        {description = "Lock screen", group = "kde"})
)

clientkeys = table.join(
    awful.key({ modkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Rules
    -- use xprop | grep WM_CLASS to find rule's class name
    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- Set applications to be maximized at startup.
    { rule = { class = editorgui },
          properties = { maximized = true } },

    { rule = { class = filemanager },
          properties = { maximized = false } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
          properties = { maximized = true } },

    { rule = { class = "Gnome-disks" },
          properties = { maximized = true } },

    { rule = { class = "inkscape" },
          properties = { maximized = true } },

    { rule = { class = "Vlc" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
          properties = { maximized = true } },

    { rule = { class = "spectacle" },
          properties = { floating = false } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Galculator",
          "kfontview",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
        },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.spawn.with_shell(string.format("%s/.config/awesome/autostart.sh -b %s", os.getenv("HOME"), bar))
