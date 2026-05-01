use std::sync::{Arc, Mutex};

use pinnacle_api::layout;
use pinnacle_api::layout::generators::{
    Corner, CornerLocation, Cycle, Dwindle, Fair, Floating, MasterSide, MasterStack, Spiral,
};
use pinnacle_api::layout::{LayoutGenerator, LayoutNode, LayoutResponse};
use pinnacle_api::util::Axis;

// pub type SharedCycler = Arc<Mutex<Cycle>>;
pub type SharedCycler = Arc<Mutex<Cycle<Box<dyn LayoutGenerator + Send>>>>;

pub type LayoutRequester = layout::LayoutRequester;

fn into_box<'a, T: LayoutGenerator + Send + 'a>(
    generator: T,
) -> Box<dyn LayoutGenerator + Send + 'a> {
    Box::new(generator) as _
}

pub fn startup() -> (SharedCycler, LayoutRequester) {
    let cycler = Arc::new(Mutex::new(Cycle::new([
        into_box(MasterStack::default()),
        into_box(MasterStack {
            master_side: MasterSide::Right,
            ..Default::default()
        }),
        into_box(MasterStack {
            master_side: MasterSide::Top,
            ..Default::default()
        }),
        into_box(MasterStack {
            master_side: MasterSide::Bottom,
            ..Default::default()
        }),
        into_box(Dwindle::default()),
        into_box(Spiral::default()),
        into_box(Corner::default()),
        into_box(Corner {
            corner_loc: CornerLocation::TopRight,
            ..Default::default()
        }),
        into_box(Corner {
            corner_loc: CornerLocation::BottomLeft,
            ..Default::default()
        }),
        into_box(Corner {
            corner_loc: CornerLocation::BottomRight,
            ..Default::default()
        }),
        into_box(Fair::default()),
        into_box(Fair {
            axis: Axis::Horizontal,
            ..Default::default()
        }),
        into_box(Floating::default()),
    ])));

    let requester = layout::manage({
        let cycler = cycler.clone();
        move |args| {
            let Some(tag) = args.tags.first() else {
                return LayoutResponse {
                    root_node: LayoutNode::new(),
                    tree_id: 0,
                };
            };

            let mut cycler = cycler.lock().unwrap();
            cycler.set_current_tag(tag.clone());

            let root_node = cycler.layout(args.window_count);
            let tree_id = cycler.current_tree_id();

            LayoutResponse { root_node, tree_id }
        }
    });

    (cycler, requester)
}
