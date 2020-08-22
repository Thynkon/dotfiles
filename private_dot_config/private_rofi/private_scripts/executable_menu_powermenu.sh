#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/menu/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')
#mem=$( free -h | grep -i mem | awk -F ' ' '{print $3}')
cpu=$(sh ~/.config/rofi/bin/usedcpu)
memory=$(sh ~/.config/rofi/bin/usedram)

# Options
shutdown="襤"
reboot="ﰇ"
lock=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime    $cpu    $memory " -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        i3lock
        ;;
    $logout)
        loginctl terminate-session $(loginctl session-status | head -n 1 | awk '{print $1}')
        ;;
esac

