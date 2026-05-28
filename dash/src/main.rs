use slint::ComponentHandle;
use std::error::Error;
use system_shutdown::{reboot, shutdown};

slint::include_modules!();

mod android_auto;

fn main() -> Result<(), Box<dyn Error>> {
    simple_logger::SimpleLogger::new()
        .with_level(log::LevelFilter::Info)
        .init()
        .ok();
    let ui = AppWindow::new()?;
    let _android_auto: android_auto::AndroidAutoHandle =
        android_auto::AndroidAutoHandle::start(&ui);

    let android_auto_handle = _android_auto.clone();
    ui.on_handle_android_auto_touch(move |x, y, action| {
        android_auto_handle.send_touch_event(x, y, action);
    });

    let ui_handle = ui.as_weak();
    ui.on_play_pause(move || {
        let ui = ui_handle.unwrap();
        ui.set_is_playing(!ui.get_is_playing());
    });

    let ui_handle = ui.as_weak();
    ui.on_toggle_loop(move || {
        let ui = ui_handle.unwrap();
        ui.set_is_loop_enabled(!ui.get_is_loop_enabled());
    });

    let ui_handle = ui.as_weak();
    ui.on_toggle_shuffle(move || {
        let ui = ui_handle.unwrap();
        ui.set_is_shuffle_enabled(!ui.get_is_shuffle_enabled());
    });

    ui.on_shutdown(move || match shutdown() {
        Ok(()) => println!("Shutting down, bye!"),
        Err(error) => eprintln!("Failed to shut down: {error}"),
    });

    ui.on_reboot(move || match reboot() {
        Ok(()) => println!("Rebooting, see you soon!"),
        Err(error) => eprintln!("Failed to reboot: {error}"),
    });

    ui.run()?;

    Ok(())
}
