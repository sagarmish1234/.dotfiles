{
  lib,
  feature,
  pkgs,
  catppuccin,
  ...
}:
lib.mkIf feature.desktop.notification.swaync {
  services.swaync.enable = true;
  catppuccin.swaync = {
    enable = true;
    flavor = "mocha";
    font = "JetBrainsMono Nerd Font";
  };
  home.packages = with pkgs; [
    libnotify # For notify-send command
    papirus-icon-theme # Icon theme
  ];
}
