mod config;

use crate::config::tags;
use pinnacle_api::input::Mod;
use pinnacle_api::pinnacle::{self, Backend};

use pinnacle_api::tag;
use std::io::{BufRead, BufReader};
use std::os::unix::net::UnixListener;
use std::thread;

pub fn start_ipc_listener() {
    thread::spawn(|| {
        let socket_path = "/tmp/pinnacle-ipc.sock";
        let _ = std::fs::remove_file(socket_path);

        let listener = UnixListener::bind(socket_path).unwrap();

        for stream in listener.incoming() {
            if let Ok(stream) = stream {
                let reader = BufReader::new(stream);
                for line in reader.lines() {
                    if let Ok(cmd) = line {
                        // Parse "switch_tag X"
                        if let Some(tag_name) = cmd.strip_prefix("switch_tag ") {
                            if let Some(tag) = tag::get(tag_name) {
                                tag.switch_to();
                            }
                        }
                    }
                }
            }
        }
    });
}

async fn config_main() {
    let mod_key = match pinnacle::backend() {
        Backend::Tty => Mod::SUPER,
        Backend::Window => Mod::ALT,
    };

    let terminal = "wezterm";

    config::startup::startup();
    config::input::startup();

    let _tags = tags::startup(mod_key);
    let (cycler, requester) = config::layouts::startup();
    config::keybinds::startup(mod_key, terminal, cycler, requester);
    config::focus::startup();

    config::outputs::startup();

    #[cfg(feature = "snowcap")]
    config::decorations::startup();

    // start_ipc_listener();

    pinnacle_api::process::Command::new(terminal).once().spawn();
}

pinnacle_api::main!(config_main);
