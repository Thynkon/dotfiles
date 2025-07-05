#!/usr/bin/env ruby

require 'json'

result = %x[swaymsg -r -t get_outputs]
monitors = JSON.parse(result)

monitors.each do |child|
  mode = child["modes"].max_by do |m|
    m["refresh"]
  end

  before_dot = mode["refresh"] / 1000
  after_dot = mode["refresh"] % 1000

  system("swaymsg output #{child["name"]} mode #{mode["width"]}x#{mode["height"]}@#{before_dot}.#{after_dot}Hz")
end

