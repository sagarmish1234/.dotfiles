{
  pkgs,
  catppuccin,
  feature,
  lib,
  ...
}:
lib.mkIf feature.desktop.launcher.rofi {
  catppuccin.rofi.enable = false;
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
