use pinnacle_api::input::{self, XkbConfig};
use pinnacle_api::process::Command;

mod keybinds;
mod keyboards;
mod layouts;
mod monitors;
mod rules;
mod tags;

async fn config() {
    input::set_xkb_config(XkbConfig::new().with_layout("ch(fr)"));
    //keyboards::setup();
    keybinds::setup();
    layouts::setup();
    tags::setup();

    input::libinput::for_each_device(|device| {
        // Enable natural scroll for touchpads
        if device.device_type().is_touchpad() {
            device.set_natural_scroll(true);
        }
    });

    rules::setup();

    #[cfg(feature = "snowcap")]
    if let Some(error) = pinnacle_api::pinnacle::take_last_error() {
        // Show previous crash messages
        pinnacle_api::snowcap::ConfigCrashedMessage::new().show(error);
    }

    monitors::layout();

    Command::new("~/.config/pinnacle/autostart.sh")
        .once()
        .spawn();
}

pinnacle_api::main!(config);
