{ pkgs, ... }:

{
  # Hypridle: The idle management daemon for Hyprland.
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
      };

      # Listeners: Define actions based on inactivity duration (in seconds).
      listener = [
        # 5 Minutes: Lock the screen.
        {
          timeout = 300; 
          on-timeout = "loginctl lock-session";
        }
        # 5.5 Minutes: Turn off the display (DPMS off) to save power.
        {
          timeout = 330; # 5.5min
          on-timeout = "niri msg action power-off-monitors"; # screen off when timeout has passed
        }
        # 30 Minutes: Suspend the computer.
        {
          timeout = 1800; 
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
