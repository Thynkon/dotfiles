#!/usr/bin/env bash

terminal="alacritty"
browser="firefox-developer-edition"
gui_editor="vscodium"
file_manager="thunar"
screenshotutility="flameshot gui"
volume_step="5"
brightness_step="10"

cat > "${HOME}/.config/sxhkd/sxhkdrc" << EOF
## launch
# terminal emulator
alt + Return
	${terminal}
# rofi
alt + d
	${HOME}/.config/rofi/bin/app_launcher.sh
# htop
alt + shift + h
	${terminal} -t 'htop task manager' -e htop
# pulseaudio control
alt + v
	pavucontrol
# browser
alt + w
	${browser}
# gui editor
alt + shift + e
	${gui_editor} --extensions-dir=${HOME}/.local/share/VSCodium/extensions
# file manager
alt + e
	${file_manager}
# device manager
alt + y
	${HOME}/.local/bin/udiskie-dmenu
# settings manager
alt + control + m
	xfce4-settings-manager
# software store
alt + control + p
	pamac-manager
# screenshot
Print
	${screenshotutility}

# make sxhkd reload its configuration files:
alt + Escape
	pkill -USR1 -x sxhkd

#
# bspwm hotkeys
#

# quit/restart bspwm
alt + shift + {q,r}
	bspc {quit,wm -r}

# close window
alt + shift + c
	bspc node -c

# alternate between the tiled and monocle layout
alt + m
	bspc desktop -l next

# send the newest marked node to the newest preselected node
alt + y
	bspc node newest.marked.local -n newest.!automatic.local

# swap the current node and the biggest window
alt + g
	bspc node -s biggest.window

#
# state/flags
#

# set the window state
alt + {t,shift + t,s,f}
	bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

# set the node flags
alt + ctrl + {m,x,y,z}
	bspc node -g {marked,locked,sticky,private}

#
# focus/swap
#
# focus the node in the given direction
alt + {_,shift + }{j,k,l,eacute}
	bspc node -{f,s} {west,south,north,east}
# focus the monitor in the given direction
alt + {_,control + }{j,eacute}
	bspc node -{f,s} {west,east}
# focus the node for the given path jump
alt + {p,b,comma,period}
	bspc node -f @{parent,brother,first,second}

# focus the next/previous window in the current desktop
alt + {_,shift + }c
	bspc node -f {next,prev}.local.!hidden.window

# focus the next/previous desktop in the current monitor
alt + bracket{left,right}
	bspc desktop -f {prev,next}.local

# focus the last node/desktop
alt + {grave,Tab}
	bspc {node,desktop} -f last

# focus the older or newer node in the focus history
# alt + {o,i}
	# bspc wm -h off; \
	# bspc node {older,newer} -f; \
	# bspc wm -h on

# focus or send to the given desktop
alt + {_,shift + }{1-9,0}
	bspc {desktop -f,node -d} '^{1-9,10}'

#
# preselect
#

# preselect the direction
alt + ctrl + {j,k,l,eacute}
	bspc node -p {west,south,north,east}

# preselect the ratio
alt + ctrl + {1-9}
	bspc node -o 0.{1-9}

# cancel the preselection for the focused node
alt + ctrl + space
	bspc node -p cancel

# cancel the preselection for the focused desktop
alt + ctrl + shift + space
	bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

#
# move/resize
#

# expand a window by moving one of its side outward
alt + alt + {h,j,k,l}
	bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

# contract a window by moving one of its side inward
alt + alt + shift + {j,k,l,eacute}
	bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

# move a floating window
alt + {Left,Down,Up,Right}
	bspc node -v {-20 0,0 20,0 -20,20 0}

## brightness
# increase
XF86MonBrightnessUp
	xbacklight -inc ${brightness_step}
# decrease
XF86MonBrightnessDown
	xbacklight -dec ${brightness_step}

## Volume
# increase
XF86AudioRaiseVolume
	amixer -q set Master ${volume_step}%+
# decrease
XF86AudioLowerVolume
	amixer -q set Master ${volume_step}%-
# mute
XF86AudioMute
	amixer -q set Master toggle
# play previous
XF86AudioPrev
	playerctl --all-players previous
# play next
XF86AudioNext
	playerctl --all-players next
# toggle
XF86AudioPlay
	playerctl --all-players play-pause
EOF
