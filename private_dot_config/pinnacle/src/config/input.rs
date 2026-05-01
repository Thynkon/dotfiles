use pinnacle_api::input;
use pinnacle_api::input::XkbConfig;

pub fn startup() {
    input::set_xkb_config(XkbConfig::new().with_layout("ch").with_variant("fr"));

    input::libinput::for_each_device(|device| {
        if device.device_type().is_touchpad() {
            device.set_natural_scroll(true);
            device.set_tap(true);
        }
    });
}
