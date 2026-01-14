{
  lib,
  feature,
  catppuccin,
  ...
}:
lib.mkIf feature.desktop.hyprlock {
  catppuccin.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
      };

      background = {
        monitor = "";
        path = "~/Pictures/Wallpapers/shaded_landscape.png";
        blur_passes = 3;
        blur_size = 8;
        noise = 0.02;
        contrast = 0.9;
        brightness = 0.7;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };

      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.25;
        dots_spacing = 0.5;
        dots_center = true;
        dots_rounding = -1;
        outer_color = "rgb(137,180,250)"; # Blue
        inner_color = "rgb(49,50,68)"; # Surface0
        font_color = "rgb(205,214,244)"; # Text
        fade_on_empty = true;
        placeholder_text = "<span foreground='##cdd6f4'>Password…</span>";
        hide_input = false;
        rounding = 12;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          color = "rgb(205,214,244)";
          font_size = 64;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] echo \"$(date +\"%A, %d %B\")\"";
          color = "rgb(180,190,254)";
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
