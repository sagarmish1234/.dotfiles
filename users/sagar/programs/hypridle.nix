{ pkgs, ... }:

{
  # Hypridle: The idle management daemon for Hyprland.
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Lock Command: Command to execute when the session is locked.
        lock_cmd = "pidof hyprlock || hyprlock"; # Ensure only one instance of hyprlock runs.
        
        # Before Sleep: Lock the session automatically before the system suspends or hibernates.
        before_sleep_cmd = "loginctl lock-session";
        
        # After Sleep: Ensure the screen turns back on after the system resumes.
        after_sleep_cmd = "hyprctl dispatch dpms on";
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
          timeout = 330; 
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on"; # Turn display back on when activity is detected.
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
