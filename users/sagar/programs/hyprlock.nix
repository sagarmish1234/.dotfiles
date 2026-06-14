{ config, pkgs, lib, ... }:

let
  text = "rgb(${config.lib.stylix.colors.base05})";
in
{
  # Hyprlock: The screen locker for the Hyprland ecosystem.
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;           # Time in seconds that the user can unlock without a password.
        no_fade_in = false;
      };

      # Background: Display the current wallpaper with a blur effect.
      background = {
        monitor = "eDP-1";
        blur_passes = 3;     # Higher values mean smoother, more intense blur.
        blur_size = 8;
        noise = 0.02;
        contrast = 0.9;
        brightness = 0.7;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };

      # Input Field: The password entry box.
      input-field = {
        monitor = "eDP-1";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        fade_on_empty = false;
        placeholder_text = "<span foreground='##c0caf5'><i>Password...</i></span>";
        hide_input = false;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        position = "0, -47";
        halign = "center";
        valign = "center";
      };

      # Labels: On-screen information (Time and Date).
      label = [
        # Time Label: Updates every second.
        {
          monitor = "eDP-1";
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          color = text;
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        # Date Label: Updates every minute.
        {
          monitor = "eDP-1";
          text = "cmd[update:60000] echo \"$(date +\"%A, %d %B\")\"";
          color = text;
          font_size = 24;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
