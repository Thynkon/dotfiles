#!/usr/bin/env ruby

# Keypad mapping for workspaces
kp_keys = {
  1 => "KP_End",
  2 => "KP_Down",
  3 => "KP_Next",
  4 => "KP_Left",
  5 => "KP_Begin"
}

mod="Mod4"

# Apply bindings using swaymsg
kp_keys.each do |i, key|
  system("swaymsg bindsym #{mod}+#{key} exec 'swaysome focus #{i}'")
  system("swaymsg bindsym #{mod}+Shift+#{key} exec 'swaysome move #{i}'")
  system("swaymsg bindsym #{mod}+Alt+#{key} exec 'swaysome focus-group #{i}'")
  system("swaymsg bindsym #{mod}+Alt+Shift+#{key} exec 'swaysome move-to-group #{i}'")
end

