#!/usr/bin/env bash

set -x

run() {
  if ! pgrep $1; then
    # $@ &
    nohup $@ >/dev/null 2>&1 &
  fi
}

# email
run protonmail-bridge --noninteractive

run nextcloud
# Wifi applet
run nm-applet

run flameshot

# Blue light filter
# run redshift

run OneDriveGUI

# nohup OneDriveGUI > /dev/null 2>&1 &

# Device manager
run udiskie

# run "numlockx on"

run gpg-agent

run waybar
run hyprpaper
run blueman-applet

# run eww daemon -c $HOME/.config/eww-which-key
hyprpm reload -n
# hyprpm update -v

ruby $HOME/.config/hypr/scripts/glove.rb

exit 0
