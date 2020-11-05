#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Display polybar on multiple monitors
# Reference: https://github.com/polybar/polybar/issues/763#issuecomment-331604987
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -c ~/.config/polybar/config.ini top &
		MONITOR=$m polybar -c ~/.config/polybar/config.ini bottom&
	done
else
   polybar -c ~/.config/polybar/config.ini top & polybar -c ~/.config/polybar/config.ini bottom &
fi
