use pinnacle_api::output;
use pinnacle_api::signal::{OutputSignal, WindowSignal};
use pinnacle_api::window;

pub fn startup() {
    window::connect_signal(WindowSignal::PointerEnter(Box::new(|win| {
        win.set_focused(true);
    })));

    output::connect_signal(OutputSignal::PointerEnter(Box::new(|output| {
        output.focus();
    })));
}
