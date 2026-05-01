use pinnacle_api::input::{self, Mod};
use pinnacle_api::tag::TagHandle;
use pinnacle_api::util::Batch;
use pinnacle_api::window;
use pinnacle_api::{output, tag};
use std::collections::HashMap;

/// Stocke les tags par output
pub type TagsPerOutput = HashMap<String, Vec<TagHandle>>;

pub fn startup(mod_key: Mod) -> TagsPerOutput {
    let tag_names = ["1", "2", "3", "4", "5"];

    // Crée les tags pour chaque output
    for output in output::get_all() {
        let tags: Vec<_> = tag::add(&output, &tag_names).collect();

        // Active le premier tag sur chaque écran
        if let Some(first) = tags.first() {
            first.set_active(true);
        }
    }

    // Keybinds pour switcher ou déplacer les fenêtres
    for tag_name in &tag_names {
        let tag_name_switch = tag_name.to_string();
        let tag_name_move = tag_name.to_string();

        // mod + [1-9] -> switch au tag de l'écran actif
        input::keybind(mod_key, tag_name_switch.clone()).on_press(move || {
            if let Some(focused_output) = output::get_focused() {
                let tag_name_ref = tag_name_switch.clone();
                if let Some(tag) = focused_output.tags().batch_find(
                    |t: &TagHandle| Box::pin(async move { t.name() }),
                    |name| *name == tag_name_ref,
                ) {
                    tag.switch_to();
                }
            }
        });

        // mod + shift + [1-9] -> déplacer la fenêtre vers le tag de l'écran actif
        input::keybind(mod_key | Mod::SHIFT, tag_name_move.clone()).on_press(move || {
            if let Some(win) = window::get_focused() {
                if let Some(focused_output) = output::get_focused() {
                    let tag_name_ref = tag_name_move.clone();
                    if let Some(tag) = focused_output.tags().batch_find(
                        |t: &TagHandle| Box::pin(async move { t.name() }),
                        |name| *name == tag_name_ref,
                    ) {
                        win.move_to_tag(&tag);
                    }
                }
            }
        });
    }

    // Construit le HashMap après avoir créé tous les tags
    let mut tags_per_output = TagsPerOutput::new();
    for output in output::get_all() {
        let tags: Vec<_> = output.tags().collect();
        tags_per_output.insert(output.name().to_string(), tags);
    }

    tags_per_output
}
