{ lib, feature, ... }:
lib.mkIf feature.desktop.hypridle {
  services.hypridle = {
    enable = true;
    settings = {
      # Commands for hypridle actions (e.g., locking, sleeping)
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      timeout = 300; # 5 minutes
    };
  };
}
