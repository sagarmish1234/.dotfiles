{ config, pkgs, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # TLP and power-profiles-daemon conflict
  services.power-profiles-daemon.enable = false;
}
