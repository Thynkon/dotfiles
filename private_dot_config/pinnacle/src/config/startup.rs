use pinnacle_api::process::Command;

pub fn startup() {
    Command::new("swaync").once().spawn();
    Command::new("wpaperd").args(["-d"]).once().spawn();
    Command::new("clipboard-sync").once().spawn();
    Command::new("copyq")
        .args(["--start-server"])
        .once()
        .spawn();
    Command::new("hypridle").once().spawn();

    Command::new("/usr/lib/hyprpolkitagent/hyprpolkitagent")
        .once()
        .spawn();

    // Command::new("sh")
    //     .args(["-c", "$HOME/.config/hypr/scripts/monitors.rb"])
    //     .once()
    //     .spawn();

    Command::new("sh")
        .args(["-c", "$HOME/.config/pinnacle/scripts/autostart.sh"])
        .once()
        .spawn();
}
