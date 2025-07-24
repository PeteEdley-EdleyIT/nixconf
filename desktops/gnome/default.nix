{ config, lib, ... }:
with lib;
let cfg = config.desktops.gnome;
in {
  options.desktops.gnome.enable = mkEnableOption "Enable gnome desktop";

  config = mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
  };
}
