{ config, pkgs, ... }:

{
  # TLP: Advanced Power Management for Linux.
  services.tlp = {
    enable = true;
    settings = {
      # Battery Longevity: Limit charging to 80% to reduce chemical aging of the battery.
      # Useful for laptops that are frequently plugged in.
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Conflict Resolution:
  # TLP and power-profiles-daemon (the GNOME/KDE default) conflict with each other.
  # We disable power-profiles-daemon to let TLP handle all power management.
  services.power-profiles-daemon.enable = false;
}
