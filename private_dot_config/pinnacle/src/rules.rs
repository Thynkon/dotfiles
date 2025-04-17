use pinnacle_api::{output, window};

pub fn setup() {
    window::add_window_rule(|rule| {
        if rule.app_id() == "flameshot" {
            // floating, no border, disable fullscreen
            rule.set_floating(true);
            //.set_border_width(0)
            rule.set_fullscreen(false);

            // move it to the focused monitor’s origin
            if let (Some(size), Some(mon)) = (rule.size(), output::get_focused()) {
                if let Some(loc) = mon.loc() {
                    rule.set_geometry(loc.x, loc.y, size.w, size.h);
                }
            }
        }
    });
}
