{
  pkgs,
  lib,
  feature,
  ...
}:
lib.mkIf feature.terminal.ghostty {

  xdg.terminal-exec.enable = true;
  xdg.terminal-exec.settings.default = [ "ghostty.desktop" ];
  programs.ghostty = {
    enable = true;
    themes = {
      catppuccin-mocha = {
        background = "1e1e2e";
        cursor-color = "f5e0dc";
        foreground = "cdd6f4";
        palette = [
          "0=#45475a"
          "1=#f38ba8"
          "2=#a6e3a1"
          "3=#f9e2af"
          "4=#89b4fa"
          "5=#f5c2e7"
          "6=#94e2d5"
          "7=#bac2de"
          "8=#585b70"
          "9=#f38ba8"
          "10=#a6e3a1"
          "11=#f9e2af"
          "12=#89b4fa"
          "13=#f5c2e7"
          "14=#94e2d5"
          "15=#a6adc8"
        ];
        selection-background = "353749";
        selection-foreground = "cdd6f4";
      };
    };
    enableFishIntegration = true;
    settings = {

      command = "${pkgs.fish}/bin/fish";

      # Font settings
      font-family = "JetBrainsMono Nerd Font";
      font-style = "Regular";
      font-size = 11;

      # Window styling
      window-theme = "ghostty";
      window-padding-x = 14;
      window-padding-y = 14;
      confirm-close-surface = false;
      resize-overlay = "never";
      gtk-toolbar-style = "flat";

      # Cursor styling
      cursor-style = "block";
      cursor-style-blink = false;

      # Shell integration (passed as a single comma-separated string)
      shell-integration-features = "no-cursor,ssh-env";

      # Keyboard bindings (Multiple values must be a list)
      keybind = [
        "shift+insert=paste_from_clipboard"
        "control+insert=copy_to_clipboard"
        "super+control+shift+alt+arrow_down=resize_split:down,100"
        "super+control+shift+alt+arrow_up=resize_split:up,100"
        "super+control+shift+alt+arrow_left=resize_split:left,100"
        "super+control+shift+alt+arrow_right=resize_split:right,100"
      ];
      theme = "catppuccin-mocha";
      # Transparency (actual blur handled by compositor)
      background-opacity = 0.75;

      # Disable titlebar
      window-decoration = false;

      # Mouse scrolling
      mouse-scroll-multiplier = 0.95;
    };
  };
}
