#!/usr/bin/env bash

run() {
  if ! pgrep $1; then
    $@ &
  fi
}

# email
run protonmail-bridge --no-window

run nextcloud
# Wifi applet
run nm-applet

# Blue light filter
run redshift

run onedrivegui

# Device manager
run udiskie

# run "numlockx on"

run gpg-agent

run waybar
run hyprpaper
run blueman-applet

# run eww daemon -c $HOME/.config/eww-which-key
hyprpm reload -n
hyprpm update -v

exit 0
