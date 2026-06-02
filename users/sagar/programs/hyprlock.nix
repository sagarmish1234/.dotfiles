{ config, pkgs, ... }:

let
  # Catppuccin Mocha palette: Defined manually for use in non-nix settings or precise overrides.
  rosewater = "rgb(245, 224, 220)";
  flamingo = "rgb(242, 205, 205)";
  pink = "rgb(245, 194, 231)";
  mauve = "rgb(203, 166, 247)";
  red = "rgb(243, 139, 168)";
  maroon = "rgb(235, 160, 172)";
  peach = "rgb(250, 179, 135)";
  yellow = "rgb(249, 226, 175)";
  green = "rgb(166, 227, 161)";
  teal = "rgb(148, 226, 213)";
  sky = "rgb(145, 215, 227)";
  sapphire = "rgb(116, 199, 236)";
  blue = "rgb(137, 180, 250)";
  lavender = "rgb(180, 190, 254)";
  text = "rgb(205, 214, 244)";
  subtext1 = "rgb(186, 194, 222)";
  subtext0 = "rgb(166, 173, 200)";
  overlay2 = "rgb(147, 153, 178)";
  overlay1 = "rgb(127, 132, 156)";
  overlay0 = "rgb(108, 112, 134)";
  surface2 = "rgb(88, 91, 112)";
  surface1 = "rgb(69, 71, 90)";
  surface0 = "rgb(49, 50, 68)";
  base = "rgb(30, 30, 46)";
  mantle = "rgb(24, 24, 37)";
  crust = "rgb(17, 17, 27)";
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
        path = "${config.home.homeDirectory}/.cache/current_wallpaper";
        color = base;
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
        outer_color = lavender;
        inner_color = surface0;
        font_color = text;
        fade_on_empty = false;
        placeholder_text = "<span foreground='##cdd6f4'><i>Password...</i></span>";
        hide_input = false;
        check_color = blue;
        fail_color = red;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = yellow;
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
