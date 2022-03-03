local awful     = require("awful") --Everything related to window managment
local beautiful = require("beautiful") -- Theme handling library
local settings  = require("lib.settings")
local keys      = require("lib.keys")
local buttons   = require("lib.buttons")

local rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.client,
      buttons = buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },
  -- Rules
  -- use xprop | grep WM_CLASS to find rule's class name
  -- Titlebars
  {
    rule_any = {type = {"dialog", "normal"}},
    properties = {titlebars_enabled = false}
  },
  -- Set applications to be maximized at startup.
  {
    rule = {class = "Firefox Developer Edition"},
    properties = {maximized = true}
  },
  {
    rule = {class = settings.editorgui},
    properties = {maximized = true}
  },
  {
    rule = {class = settings.filemanager},
    properties = {maximized = false}
  },
  {
    rule = {class = "Gimp*", role = "gimp-image-window"},
    properties = {maximized = true}
  },
  {
    rule = {class = "Gnome-disks"},
    properties = {maximized = true}
  },
  {
    rule = {class = "inkscape"},
    properties = {maximized = true}
  },
  {
    rule = {class = "Vlc"},
    properties = {maximized = true}
  },
  {
    rule = {class = "VirtualBox Manager"},
    properties = {maximized = true}
  },
  {
    rule = {class = "VirtualBox Machine"},
    properties = {maximized = true}
  },
  {
    rule = {class = "spectacle"},
    properties = {floating = false}
  },
  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- Firefox addon DownThemAll.
        "copyq" -- Includes session name in class.
      },
      class = {
        "Galculator",
        "kfontview",
        "Gpick",
        "Imagewriter",
        "Font-manager",
        "Kruler"
      },
      name = {
        "Event Tester" -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
        "Preferences",
        "setup"
      }
    },
    properties = {floating = true}
  }
}

return rules
