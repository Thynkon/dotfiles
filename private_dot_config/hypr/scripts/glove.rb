#!/usr/bin/env ruby

# Keypad mapping for workspaces
kp_keys = {
  1 => 'KP_End',
  2 => 'KP_Down',
  3 => 'KP_Next',
  4 => 'KP_Left',
  5 => 'KP_Begin'
}

mod = 'SUPER'

# Print Hyprland bindings
kp_keys.each do |i, key|
  system "hyprctl keyword bind #{mod},#{key},split:workspace,#{i}"
end
