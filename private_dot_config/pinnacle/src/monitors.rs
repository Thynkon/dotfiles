use pinnacle_api::output;

pub fn layout() {
    for out in output::get_all() {
        if out.name().starts_with("HDMI") {
            out.set_loc(1920, 0);
            let modes = out.modes();
            if let Some(max_mode) = modes.max_by_key(|mode| mode.refresh_rate_mhz) {
                out.set_mode(max_mode.size.w, max_mode.size.h, max_mode.refresh_rate_mhz);
            }
        } else if out.name().starts_with("eDP") {
            out.set_loc(0, 0);
        }
    }
}
