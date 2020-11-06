#!/usr/bin/env sh

POLYBAR_CONFIG_PATH="${HOME}/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

nic=$("${POLYBAR_CONFIG_PATH}/scripts/get-nic.sh")

# Display polybar on multiple monitors
# Reference: https://github.com/polybar/polybar/issues/763#issuecomment-331604987
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar -c "${POLYBAR_CONFIG_PATH}/config.ini" top &
		MONITOR=$m NETWORK_INTERFACE="${nic}" polybar -c "${POLYBAR_CONFIG_PATH}/config.ini" bottom&
	done
else
   polybar -c "${POLYBAR_CONFIG_PATH}/config.ini" top &
   NETWORK_INTERFACE="${nic}" polybar -c "${POLYBAR_CONFIG_PATH}/config.ini" bottom &
fi
