use pinnacle_api::input;
use pinnacle_api::input::Bind;
use pinnacle_api::input::Keysym;
use pinnacle_api::input::{Mod, MouseButton};
use pinnacle_api::output;
use pinnacle_api::pinnacle;
use pinnacle_api::pinnacle::Backend;
use pinnacle_api::process::Command;
use pinnacle_api::window;

pub fn get_mod_key() -> Mod {
    // Change the mod key to `Alt` when running as a nested window.
    match pinnacle::backend() {
        Backend::Tty => Mod::SUPER,
        Backend::Window => Mod::ALT,
    }
}

fn launcher() {
    let terminal = "wezterm";
    let launcher = "anyrun";
    let mod_key = get_mod_key();

    // `mod_key + Return` spawns a terminal
    input::keybind(mod_key, Keysym::Return)
        .on_press(move || {
            Command::new(terminal).spawn();
        })
        .group("Apps")
        .description("Spawn a terminal");

    input::keybind(mod_key, Keysym::d)
        .on_press(move || {
            Command::new(launcher).spawn();
        })
        .group("Apps")
        .description("Spawn the app launcher");

    input::keybind(Mod::IGNORE_SUPER, Keysym::Print)
        .on_press(|| {
            Command::new("flameshot").arg("gui").spawn();
        })
        .group("Apps")
        .description("Take a screenshot using flameshot");

    input::keybind(mod_key | Mod::CTRL, Keysym::l)
        .on_press(|| {
            Command::new("swaylock").spawn();
        })
        .group("Session")
        .description("Lock the screen with swaylock");

    input::keybind(mod_key, Keysym::e)
        .on_press(|| {
            Command::new("thunar").spawn();
        })
        .group("Apps")
        .description("Open Thunar file manager");
}

fn volume_media() {
    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioRaiseVolume).on_press(|| {
        Command::new("pamixer").args(["-ui", "2"]).spawn();
    });

    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioLowerVolume).on_press(|| {
        Command::new("pamixer").args(["-ud", "2"]).spawn();
    });

    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioMute).on_press(|| {
        Command::new("pamixer").args(["--toggle-mute"]).spawn();
    });

    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioPlay).on_press(|| {
        Command::new("playerctl").arg("play-pause").spawn();
    });

    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioPause).on_press(|| {
        Command::new("playerctl").arg("pause").spawn();
    });

    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioNext).on_press(|| {
        Command::new("playerctl").arg("next").spawn();
    });

    input::keybind(Mod::IGNORE_SUPER, Keysym::XF86_AudioPrev).on_press(|| {
        Command::new("playerctl").arg("previous").spawn();
    });
}

fn compositor() {
    let mod_key = get_mod_key();

    // `mod_key + s` shows the bindings overlay
    #[cfg(feature = "snowcap")]
    input::keybind(mod_key, 's')
        .on_press(|| {
            pinnacle_api::snowcap::BindOverlay::new().show();
        })
        .group("Compositor")
        .description("Show the bindings overlay");

    // `mod_key + shift + q` quits Pinnacle
    #[cfg(not(feature = "snowcap"))]
    input::keybind(mod_key | Mod::SHIFT, 'q')
        .set_as_quit()
        .group("Compositor")
        .description("Quit Pinnacle");

    #[cfg(feature = "snowcap")]
    {
        // `mod_key + shift + q` shows the quit prompt
        input::keybind(mod_key | Mod::SHIFT, 'q')
            .on_press(|| {
                pinnacle_api::snowcap::QuitPrompt::new().show();
            })
            .group("Compositor")
            .description("Show quit prompt");

        // `mod_key + ctrl + shift + q` for the hard shutdown
        input::keybind(mod_key | Mod::CTRL | Mod::SHIFT, 'q')
            .set_as_quit()
            .group("Compositor")
            .description("Quit Pinnacle without prompt");
    }

    // `mod_key + ctrl + r` reloads the config
    input::keybind(mod_key | Mod::CTRL, 'r')
        .set_as_reload_config()
        .group("Compositor")
        .description("Reload the config");

    // `mod_key + c` closes the focused window
    input::keybind(mod_key, 'c')
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.close();
            }
        })
        .group("Window")
        .description("Close the focused window");

    // `mod_key + ctrl + space` toggles floating
    input::keybind(mod_key | Mod::CTRL, Keysym::space)
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.toggle_floating();
                window.raise();
            }
        })
        .group("Window")
        .description("Toggle floating on the focused window");

    // `mod_key + f` toggles fullscreen
    input::keybind(mod_key, 'f')
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.toggle_fullscreen();
                window.raise();
            }
        })
        .group("Window")
        .description("Toggle fullscreen on the focused window");

    // `mod_key + m` toggles maximized
    input::keybind(mod_key, 'm')
        .on_press(|| {
            if let Some(window) = window::get_focused() {
                window.toggle_maximized();
                window.raise();
            }
        })
        .group("Window")
        .description("Toggle maximized on the focused window");
}

fn mouse() {
    let mod_key = get_mod_key();

    // `mod_key + left click` starts moving a window
    input::mousebind(mod_key, MouseButton::Left)
        .on_press(|| {
            window::begin_move(MouseButton::Left);
        })
        .group("Mouse")
        .description("Start an interactive window move");

    // `mod_key + right click` starts resizing a window
    input::mousebind(mod_key, MouseButton::Right)
        .on_press(|| {
            window::begin_resize(MouseButton::Right);
        })
        .group("Mouse")
        .description("Start an interactive window resize");
}

pub fn setup() {
    mouse();
    launcher();
    volume_media();
    compositor();
}
