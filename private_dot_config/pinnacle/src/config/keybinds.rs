use std::sync::{Arc, Mutex};

use pinnacle_api::input;
use pinnacle_api::input::Bind;
use pinnacle_api::input::{Keysym, Mod, MouseButton};
use pinnacle_api::layout::generators::Cycle;
use pinnacle_api::output;
use pinnacle_api::process::Command;
use pinnacle_api::tag;
use pinnacle_api::util::Batch;
use pinnacle_api::window;

use crate::config::layouts::{LayoutRequester, SharedCycler};

pub fn startup(
    mod_key: Mod,
    terminal: &'static str,
    cycler: SharedCycler,
    layout_requester: LayoutRequester,
) {
    // Program definitions
    let file_manager = "thunar";
    let menu = "walker";
    let browser = "zen-browser";
    let notification_client = "swaync-client";
    let screen_locker = "hyprlock";
    let screenshot_tool = "flameshot";
    let brightness_control = "brightnessctl";
    let audio_control = "wpctl";
    let media_player_control = "playerctl";
    let udiskie_script = "$HOME/.local/bin/udiskie-dmenu";

    // Mouse binds
    input::mousebind(mod_key, MouseButton::Left).on_press(|| {
        window::begin_move(MouseButton::Left);
    });

    input::mousebind(mod_key, MouseButton::Right).on_press(|| {
        window::begin_resize(MouseButton::Right);
    });

    // Reload config
    input::keybind(mod_key | Mod::CTRL, 'r').set_as_reload_config();

    // Quit
    input::keybind(mod_key | Mod::SHIFT, 'q').set_as_quit();

    // Terminal
    input::keybind(mod_key, Keysym::Return).on_press(move || {
        Command::new(terminal).spawn();
    });

    // File manager
    input::keybind(mod_key, 'e').on_press(move || {
        Command::new(file_manager).spawn();
    });

    // Menu
    input::keybind(mod_key, 'd').on_press(move || {
        Command::new(menu).spawn();
    });

    // Browser
    input::keybind(mod_key, 'w').on_press(move || {
        Command::new(browser).spawn();
    });

    // udiskie dmenu
    input::keybind(mod_key, 'y').on_press(move || {
        Command::new("sh").args(["-c", udiskie_script]).spawn();
    });

    // Close window
    input::keybind(mod_key, 'c').on_press(|| {
        if let Some(win) = window::get_focused() {
            win.close();
        }
    });

    // Toggle fullscreen
    input::keybind(mod_key, 'f').on_press(|| {
        if let Some(win) = window::get_focused() {
            win.toggle_fullscreen();
            win.raise();
        }
    });

    // Toggle floating
    input::keybind(mod_key, 'v').on_press(|| {
        if let Some(win) = window::get_focused() {
            win.toggle_floating();
            win.raise();
        }
    });

    // swaync control center
    input::keybind(mod_key | Mod::SHIFT, 'n').on_press(move || {
        Command::new(notification_client)
            .args(["-t", "-sw"])
            .spawn();
    });

    // Lock
    input::keybind(mod_key | Mod::CTRL, 'l').on_press(move || {
        Command::new(screen_locker).spawn();
    });

    // Screenshot
    input::keybind(Mod::empty(), Keysym::Print).on_press(move || {
        Command::new(screenshot_tool).args(["gui"]).spawn();
    });

    // Brightness
    input::keybind(Mod::empty(), Keysym::XF86_MonBrightnessUp).on_press(move || {
        Command::new(brightness_control)
            .args(["set", "+10%"])
            .spawn();
    });

    input::keybind(Mod::empty(), Keysym::XF86_MonBrightnessDown).on_press(move || {
        Command::new(brightness_control)
            .args(["set", "10%-"])
            .spawn();
    });

    // Volume
    input::keybind(Mod::empty(), Keysym::XF86_AudioRaiseVolume).on_press(move || {
        Command::new(audio_control)
            .args(["set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"])
            .spawn();
    });

    input::keybind(Mod::empty(), Keysym::XF86_AudioLowerVolume).on_press(move || {
        Command::new(audio_control)
            .args(["set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"])
            .spawn();
    });

    input::keybind(Mod::empty(), Keysym::XF86_AudioMute).on_press(move || {
        Command::new(audio_control)
            .args(["set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
            .spawn();
    });

    // Media
    input::keybind(Mod::empty(), Keysym::XF86_AudioPrev).on_press(move || {
        Command::new(media_player_control).arg("previous").spawn();
    });

    input::keybind(Mod::empty(), Keysym::XF86_AudioNext).on_press(move || {
        Command::new(media_player_control).arg("next").spawn();
    });

    input::keybind(Mod::empty(), Keysym::XF86_AudioPlay).on_press(move || {
        Command::new(media_player_control).arg("play-pause").spawn();
    });

    // Layout cycle
    input::keybind(mod_key, Keysym::space).on_press({
        let cycler = cycler.clone();
        let requester = layout_requester.clone();
        move || {
            let Some(focused_op) = output::get_focused() else {
                return;
            };

            let Some(first_active_tag) = focused_op
                .tags()
                .batch_find(|tag| Box::pin(tag.active_async()), |active| *active)
            else {
                return;
            };

            cycler
                .lock()
                .unwrap()
                .cycle_layout_forward(&first_active_tag);
            requester.request_layout_on_output(&focused_op);
        }
    });

    input::keybind(mod_key | Mod::SHIFT, Keysym::space).on_press(move || {
        let Some(focused_op) = output::get_focused() else {
            return;
        };

        let Some(first_active_tag) = focused_op
            .tags()
            .batch_find(|tag| Box::pin(tag.active_async()), |active| *active)
        else {
            return;
        };

        cycler
            .lock()
            .unwrap()
            .cycle_layout_backward(&first_active_tag);
        layout_requester.request_layout_on_output(&focused_op);
    });

    // Tags 1-5
    for tag_name in ["1", "2", "3", "4", "5"] {
        input::keybind(mod_key, tag_name).on_press(move || {
            if let Some(tag) = tag::get(tag_name) {
                tag.switch_to();
            }
        });

        input::keybind(mod_key | Mod::SHIFT, tag_name).on_press(move || {
            if let Some(tag) = tag::get(tag_name)
                && let Some(win) = window::get_focused()
            {
                win.move_to_tag(&tag);
            }
        });
    }
}
