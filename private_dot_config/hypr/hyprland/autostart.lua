-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("~/.config/hypr/scripts/autostart.sh")
	hl.exec_cmd("swaync")
	hl.exec_cmd("wpaperd -d")
	hl.exec_cmd("clipboard-sync&")
	hl.exec_cmd("copyq")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
end)
