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

run OneDriveGUI

# Device manager
run udiskie

# run "numlockx on"

run gpg-agent

run waybar
run hyprpaper
run blueman-applet

run swaysome init 1

run swaync
run wpaperd -d

exit 0
