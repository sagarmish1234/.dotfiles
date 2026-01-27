{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.desktop.notification.swaync {
  services.swaync.enable = true;
  home.packages = with pkgs; [
    libnotify # For notify-send command
  ];
}
