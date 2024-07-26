-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.colors = require("cyberdream")

config.font = wezterm.font("Jetbrains Mono")
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.audible_bell = "Disabled"

-- config.default_prog = { "zellij", "-l", "welcome" }

-- and finally, return the configuration to wezterm
return config
