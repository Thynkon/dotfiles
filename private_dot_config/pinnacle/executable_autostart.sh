#!/bin/bash

# Helper: Run a command only if not already running
run_once() {
  if ! pgrep -f "$1" >/dev/null; then
    eval "$1 &"
  fi
}

# Auth with polkit-gnome
run_once "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"

# Desktop notifications
run_once "mako"

# GTK3 env setup
#systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
#hash dbus-update-activation-environment 2>/dev/null &&
#  dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

# Sway Fader
#run_once "python3 ~/.config/sway/scripts/swayfader.py"

# Autotiling
#run_once "autotiling"

# nm-applet
run_once "nm-applet --indicator"

# Welcome
#run_once "dex -a -s /etc/xdg/autostart/:~/.config/autostart/"

# cliphist (text and image watchers)
run_once "wl-paste --type text --watch cliphist store"
run_once "wl-paste --type image --watch cliphist store"

# Gnome Keyring
run_once "gnome-keyring-daemon --daemonize --start --components=gpg,pkcs11,secrets,ssh"

# Touchpad gestures
run_once "libinput-gestures-setup start"

# Outputs
##run_once "kanshi"

# nwg-drawer (always run — no check)
nwg-drawer -r -c 7 -is 90 -mb 10 -ml 50 -mr 50 -mt 10 &

# wallpaper daemon
run_once "wpaperd -d"

# Bluetooth applet
run_once "blueman-applet"

# swaysome
#run_once "swaysome init 1"

# OneDrive GUI
run_once "OneDriveGUI"

run_once "waybar"
