use pinnacle_api::output;

pub fn startup() {
    output::for_each_output(|output| {
        let modes = output.modes();

        let best_mode = modes.max_by(|a, b| {
            let pixels_a = a.size.w * a.size.h;
            let pixels_b = b.size.w * b.size.h;

            match pixels_a.cmp(&pixels_b) {
                std::cmp::Ordering::Equal => a.refresh_rate_mhz.cmp(&b.refresh_rate_mhz),
                other => other,
            }
        });

        if let Some(mode) = best_mode {
            println!(
                "Setting output {} to {}x{}@{}Hz",
                output.name(),
                mode.size.w,
                mode.size.h,
                mode.refresh_rate_mhz / 1000
            );

            output.set_mode(mode.size.w, mode.size.h, Some(mode.refresh_rate_mhz));
            output.set_scale(1.0);
        } else {
            eprintln!("No modes available for output: {}", output.name());
        }
    });
}
