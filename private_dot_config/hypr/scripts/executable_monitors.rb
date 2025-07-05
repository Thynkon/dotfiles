#!/usr/bin/env ruby
require 'json'

def get_monitors
  # Get monitor information
  monitors_json = `hyprctl monitors -j`
  JSON.parse(monitors_json)
end

def extract_res_freq(mode)
  res, freq = mode.split('@')
  freq = freq.sub('Hz', '').to_i

  {
    "res": res,
    "freq": freq
  }
end

def get_main_monitor_res(monitors, main_monitor)
  monitor = monitors.find { |m| m['name'] == main_monitor }

  mode = monitor['availableModes'].max_by do |mode|
    extract_res_freq(mode)[:freq]
  end

  extract_res_freq(mode)[:res]
end

def exec_cmd(cmd, debug_mode)
  if debug_mode
    puts(cmd)
  else
    system(cmd)
  end
end

def setup_monitors(debug_mode: false)
  monitors = get_monitors

  main_monitor = 'eDP-1'
  laptop_mode = monitors.any? { |monitor| monitor['name'] == main_monitor }
  main_monitor = 'HDMI-A-1' unless laptop_mode
  main_monitor_res = get_main_monitor_res(monitors, main_monitor)

  monitors.each do |monitor|
    name = monitor['name']
    max_freq = monitor['availableModes'].max_by { |mode| extract_res_freq(mode)[:freq] }

    width = main_monitor_res.split('x').first

    cmd = if name == main_monitor
            "hyprctl keyword monitor \"#{name},#{max_freq}, 0x0, 1\""
          else
            "hyprctl keyword monitor \"#{name},#{max_freq}, #{width}x0, 1\""
          end

    exec_cmd(cmd, debug_mode)
  end
end

setup_monitors(debug_mode: true)
