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
      # Transparency (actual blur handled by compositor)
      background-opacity = 0.75;

      # Disable titlebar
      window-decoration = false;

      # Mouse scrolling
      mouse-scroll-multiplier = 0.95;
    };
  };
}
