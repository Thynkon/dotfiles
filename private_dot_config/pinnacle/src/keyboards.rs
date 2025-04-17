use pinnacle_api::input::{self, XkbConfig};

pub fn setup() {
    let kb_1_locale = "ch";
    let kb_1_variant = "fr";

    input::set_xkb_config(
        // XkbConfig::new().with_layout(&format!("{}({})", kb_1_locale, kb_1_variant)),
        XkbConfig::new().with_layout("ch(fr)"),
    );
}
