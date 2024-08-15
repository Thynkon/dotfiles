#!/usr/bin/env bash

usage() {
	echo -e "Usage:"
	echo -e "-b\tbar"
}

run() {
	if ! pgrep $1; then
		$@ &
	fi
}

bar=""
while getopts "b:h" OPTION; do
	case ${OPTION} in
	b)
		bar="${OPTARG}"
		;;

	h)
		usage
		exit 0
		;;

	*)
		usage
		exit 1
		;;
	esac
done

if [[ -z "${bar}" ]]; then
	echo "You must specify what bar to use!"
	exit 1
fi

# Daemonize compton
run compton -c --backend glx --vsync opengl-swc --blur-background

run bitcoin -min

# email
run protonmail-bridge --no-window

run nextcloud
# Wifi applet
run nm-applet

# Blue light filter
run redshift

run onedrivegui

# run safeeyes

# Device manager
run udiskie

run "numlockx on"

run gpg-agent

if [[ "${bar}" = "polybar" ]]; then
	run "${HOME}/.config/polybar/launch.sh"
fi

exit 0
