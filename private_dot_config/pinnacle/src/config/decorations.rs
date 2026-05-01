// #[cfg(feature = "snowcap")]
// pub fn startup() {
//     use pinnacle_api::snowcap::FocusBorder;
//     use pinnacle_api::window;
//
//     for win in window::get_all() {
//         let _ = FocusBorder::new_with_titlebar(&win).decorate();
//     }
//
//     window::add_window_rule(move |window| {
//         // window.set_decoration_mode(window::DecorationMode::ServerSide);
//         window.set_decoration_mode(window::DecorationMode::ServerSide);
//         let _ = FocusBorder::new_with_titlebar(&window).decorate();
//     });
// }
//
//
#[cfg(feature = "snowcap")]
pub fn startup() {
    use pinnacle_api::snowcap::FocusBorder;
    use pinnacle_api::window;

    // Borders only, no titlebars or buttons
    for win in window::get_all() {
        let _ = FocusBorder::new(&win).decorate();
    }

    // Apply same rule to new windows
    window::add_window_rule(move |win| {
        let _ = FocusBorder::new(&win).decorate();
    });
}
