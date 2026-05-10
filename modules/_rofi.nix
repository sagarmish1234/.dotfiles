{
  pkgs,
  feature,
  lib,
  ...
}:
lib.mkIf feature.desktop.launcher.rofi {
  programs.rofi = {
    enable = true;
  };
  home.file = {
    ".config/rofi" = {
      source = ../config/rofi/files;
      recursive = true;
    };
  };
}
