local awesome, client, screen = awesome, client, screen
local ipairs, string, os, tostring = ipairs, string, os, tostring

local awful             = require("awful") -- Everything related to window managment
local hotkeys_popup     = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local gears             = require("gears") -- Utilities such as color parsing and objects
local beautiful         = require("beautiful") -- Theme handling library
local settings          = require("lib.settings")
local lain              = require("lain")

local table = gears.table

local root_keys = table.join(
  -- awesome
  -- Show/Hide Wibox
  awful.key(
    {settings.modkey},
    "b",
    function()
      for s in screen do
        s.topwibox.visible = not s.topwibox.visible
        if s.bottomwibox then
          s.bottomwibox.visible = not s.bottomwibox.visible
        end
      end
    end,
    {description = "toggle wibox", group = "awesome"}
  ),
  awful.key({settings.modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
  -- Show/Hide Systray
  awful.key(
    {settings.modkey},
    "KP_Subtract",
    function()
      awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end,
    {description = "Toggle systray visibility", group = "awesome"}
  ),
  awful.key({settings.modkey, "Shift"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
  awful.key(
    {settings.superkey},
    "x",
    function()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().promptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}
  ),
  -- launcher
  awful.key(
    {settings.modkey},
    "Return",
    function()
      awful.spawn(settings.terminal)
    end,
    {description = settings.terminal, group = "launcher"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "h",
    function()
      awful.spawn(string.format("%s -t 'htop task manager' -e htop", settings.terminal))
    end,
    {description = "htop", group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "v",
    function()
      awful.spawn("pavucontrol")
    end,
    {description = "pulseaudio control", group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "w",
    function()
      awful.spawn(settings.browser)
    end,
    {description = settings.browser, group = "launcher"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "e",
    function()
      awful.spawn(settings.editorgui)
    end,
    {description = settings.editorgui, group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "F3",
    function()
      awful.spawn("inkscape")
    end,
    {description = "inkscape", group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "g",
    function()
      awful.spawn(settings.imageeditor)
    end,
    {description = settings.imageeditor, group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "F6",
    function()
      awful.spawn("vlc --video-on-top")
    end,
    {description = "vlc", group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "F7",
    function()
      awful.spawn("virtualbox")
    end,
    {description = settings.virtualmachine, group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "e",
    function()
      awful.spawn(settings.filemanager)
    end,
    {description = settings.filemanager, group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "F9",
    function()
      awful.spawn(settings.mailclient)
    end,
    {description = settings.mailclient, group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "d",
    function()
      awful.spawn(string.format("%s/bin/app_launcher.sh", settings.rofi_config))
    end,
    {description = "rofi", group = "launcher"}
  ),
  awful.key(
    {settings.modkey},
    "y",
    function()
      awful.spawn(string.format("%s/.local/bin/udiskie-dmenu", os.getenv("HOME")))
    end,
    {description = "Device manager", group = "launcher"}
  ),
  -- super + ...
  awful.key(
    {settings.modkey},
    "u",
    function()
      awful.screen.focused().promptbox:run()
    end,
    {description = "run prompt", group = "super"}
  ),
  awful.key(
    {settings.modkey},
    "x",
    function()
      awful.spawn("oblogout")
    end,
    {description = "exit", group = "hotkeys"}
  ),
  awful.key(
    {settings.modkey},
    "Escape",
    function()
      awful.spawn("xkill")
    end,
    {description = "Kill proces", group = "hotkeys"}
  ),
  -- ctrl+alt +  ...
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "c",
    function()
      awful.spawn("catfish")
    end,
    {description = "catfish", group = "alt+ctrl"}
  ),
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "o",
    function()
      awful.spawn.with_shell("$HOME/.config/awesome/scripts/compton-toggle.sh")
    end,
    {description = "Compton toggle", group = "alt+ctrl"}
  ),
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "m",
    function()
      awful.spawn("xfce4-settings-manager")
    end,
    {description = string.format("%s settings manager", settings.desktopenvironment), group = "alt+ctrl"}
  ),
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "p",
    function()
      awful.spawn("pamac-manager")
    end,
    {description = string.format("%s store", settings.desktopenvironment), group = "alt+ctrl"}
  ),
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "m",
    function()
      awful.spawn("systemsettings5")
    end,
    {description = string.format("%s settings manager", settings.desktopenvironment), group = "alt+ctrl"}
  ),
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "p",
    function()
      awful.spawn("plasma-discover")
    end,
    {description = string.format("%s store", settings.desktopenvironment), group = "alt+ctrl"}
  ),
  -- screenshots
  awful.key(
    {},
    "Print",
    function()
      awful.spawn(settings.screenshotutility)
    end,
    {description = "Screenshot", group = "screenshots"}
  ),
  -- Default client focus
  awful.key(
    {settings.modkey},
    "k",
    function()
      awful.client.focus.bydirection("down")
    end,
    {description = "Focus down", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "l",
    function()
      awful.client.focus.bydirection("up")
    end,
    {description = "Focus up", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "j",
    function()
      awful.client.focus.global_bydirection("left")
    end,
    {description = "Focus left", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "é",
    function()
      awful.client.focus.global_bydirection("right")
    end,
    {description = "Focus right", group = "client"}
  ),
  -- Layout manipulation
  awful.key(
    {settings.modkey, "Shift"},
    "é",
    function()
      awful.client.swap.byidx(1)
    end,
    {description = "swap with next client by index", group = "client"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "j",
    function()
      awful.client.swap.byidx(-1)
    end,
    {description = "swap with previous client by index", group = "client"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "é",
    function()
      awful.screen.focus_relative(1)
    end,
    {description = "focus the next screen", group = "screen"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "j",
    function()
      awful.screen.focus_relative(-1)
    end,
    {description = "focus the previous screen", group = "screen"}
  ),
  awful.key({settings.modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
  awful.key(
    {settings.modkey},
    "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}
  ),
  -- Tag
  -- Tag browsing
  awful.key({settings.modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
  awful.key({settings.modkey}, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
  awful.key({settings.modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),
  -- Non-empty tag browsing
  awful.key(
    {settings.modkey},
    "Left",
    function()
      lain.util.tag_view_nonempty(-1)
    end,
    {description = "view  previous nonempty", group = "tag"}
  ),
  awful.key(
    {settings.modkey},
    "Right",
    function()
      lain.util.tag_view_nonempty(1)
    end,
    {description = "view  previous nonempty", group = "tag"}
  ),
  -- On the fly useless gaps change
  awful.key(
    {settings.modkey, "Control"},
    "+",
    function()
      lain.util.useless_gaps_resize(1)
    end,
    {description = "increment useless gaps", group = "tag"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "-",
    function()
      lain.util.useless_gaps_resize(-1)
    end,
    {description = "decrement useless gaps", group = "tag"}
  ),
  -- Dynamic tagging
  awful.key(
    {settings.modkey, "Shift"},
    "n",
    function()
      lain.util.add_tag()
    end,
    {description = "add new tag", group = "tag"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "r",
    function()
      lain.util.rename_tag()
    end,
    {description = "rename tag", group = "tag"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "Left",
    function()
      lain.util.move_tag(-1)
    end,
    {description = "move tag to the left", group = "tag"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "Right",
    function()
      lain.util.move_tag(1)
    end,
    {description = "move tag to the right", group = "tag"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "d",
    function()
      lain.util.delete_tag()
    end,
    {description = "delete tag", group = "tag"}
  ),
  -- layout
  awful.key(
    {settings.modkey, "Shift"},
    "l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = "increase master width factor", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = "decrease master width factor", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "h",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = "increase the number of master clients", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "l",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = "decrease the number of master clients", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "h",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    {description = "increase the number of columns", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "l",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {description = "decrease the number of columns", group = "layout"}
  ),
  awful.key(
    {settings.modkey},
    "space",
    function()
      awful.layout.inc(1)
    end,
    {description = "select next", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "space",
    function()
      awful.layout.inc(-1)
    end,
    {description = "select previous", group = "layout"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    {description = "restore minimized", group = "client"}
  ),
  -- Brightness
  awful.key(
    {},
    "XF86MonBrightnessUp",
    function()
      os.execute(string.format("brightnessctl set +%d%%", settings.brightness_step))
    end,
    {description = string.format("+%d%%", settings.brightness_step), group = "hotkeys"}
  ),
  awful.key(
    {},
    "XF86MonBrightnessDown",
    function()
      os.execute(string.format("brightnessctl set %d-%%", settings.brightness_step))
    end,
    {description = string.format("-%d%%", settings.brightness_step), group = "hotkeys"}
  ),
  -- volume
  awful.key(
    {},
    "XF86AudioRaiseVolume",
    function()
      os.execute(string.format("amixer -q set %s %d%%+", beautiful.volume.channel, settings.volume_step))
      beautiful.volume.update()
    end,
    {description = string.format("+%d%%", settings.volume_step), group = "audio"}
  ),
  awful.key(
    {},
    "XF86AudioLowerVolume",
    function()
      os.execute(string.format("amixer -q set %s %d%%-", beautiful.volume.channel, settings.volume_step))
      beautiful.volume.update()
    end,
    {description = string.format("-%d%%", settings.volume_step), group = "audio"}
  ),
  awful.key(
    {},
    "XF86AudioMute",
    function()
      os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
      beautiful.volume.update()
    end,
    {description = "Mute volume", group = "audio"}
  ),
  awful.key(
    {},
    "XF86AudioPrev",
    function()
      os.execute("playerctl --all-players previous")
    end,
    {description = "select previous", group = "audio"}
  ),
  awful.key(
    {},
    "XF86AudioNext",
    function()
      os.execute("playerctl --all-players next")
    end,
    {description = "select next", group = "audio"}
  ),
  awful.key(
    {},
    "XF86AudioPlay",
    function()
      os.execute("playerctl --all-players play-pause")
    end,
    {description = "toggle", group = "audio"}
  ),
  -- Copy primary to clipboard (terminals to gtk)
  awful.key(
    {settings.ctrlkey, "Shift"},
    "c",
    function()
      awful.spawn.with_shell("xsel | xsel -i -b")
    end,
    {description = "copy terminal to gtk", group = "hotkeys"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "q",
    function()
      awful.spawn(string.format("%s/bin/menu_powermenu.sh", settings.rofi_config))
    end,
    {description = "Logout with confirmation", group = settings.desktopenvironment}
  ),
  awful.key(
    {settings.ctrlkey, settings.superkey},
    "k",
    function()
      os.execute("loginctl lock-session")
    end,
    {description = "Lock screen", group = settings.desktopenvironment}
  )
)

local client_keys = table.join(
  awful.key({settings.modkey, "Shift"}, "m", lain.util.magnify_client, {description = "magnify client", group = "client"}),
  awful.key(
    {settings.modkey},
    "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}
  ),
  awful.key(
    {settings.modkey, "Shift"},
    "c",
    function(c)
      c:kill()
    end,
    {description = "close", group = "client"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "space",
    awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}
  ),
  awful.key(
    {settings.modkey, "Control"},
    "Return",
    function(c)
      c:swap(awful.client.getmaster())
    end,
    {description = "move to master", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "o",
    function(c)
      c:move_to_screen()
    end,
    {description = "move to screen", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "t",
    function(c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    {description = "minimize", group = "client"}
  ),
  awful.key(
    {settings.modkey},
    "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "maximize", group = "client"}
  )
)

local keys = {
        root = root_keys,
        client = client_keys,
}

return keys
