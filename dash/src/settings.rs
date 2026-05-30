use crate::AppWindow;

pub struct SettingsController;

impl SettingsController {
    pub fn new(ui: &AppWindow) -> Self {
        ui.on_shutdown(move || match system_shutdown::shutdown() {
            Ok(()) => println!("Shutting down, bye!"),
            Err(error) => eprintln!("Failed to shut down: {error}"),
        });

        ui.on_reboot(move || match system_shutdown::reboot() {
            Ok(()) => println!("Rebooting, see you soon!"),
            Err(error) => eprintln!("Failed to reboot: {error}"),
        });

        Self
    }
}
