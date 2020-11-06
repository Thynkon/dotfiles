#!/usr/bin/env bash

cat "${HOME}/.config/sxhkd/sxhkdrc" |
	awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' |
	column -t -s $'\t' |
	rofi -dmenu -i -no-show-icons -width 1000 -theme "${HOME}"/.config/rofi/launchers/style_normal.rasi
