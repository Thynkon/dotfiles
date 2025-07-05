#!/usr/bin/env ruby
require 'json'

# Get monitor information
monitors_json = `hyprctl monitors -j`
monitors = JSON.parse(monitors_json)

laptop = 'eDP-1'
laptop_res = 0

monitors.each do |monitor|
  name = monitor['name']
  max_freq = monitor['availableModes'].max_by do |mode|
    res, freq = mode.split('@')
    laptop_res = res if name == laptop
    freq.sub('Hz', '').to_i
  end

  width = laptop_res.split('x').first

  if name == laptop
    system("hyprctl keyword monitor \"#{name},#{max_freq}, 0x0, 1\"")
  else
    system("hyprctl keyword monitor \"#{name},#{max_freq}, #{width}x0, 1\"")
  end
end
