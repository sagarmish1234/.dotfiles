{ pkgs, inputs, ... }:
{
  imports = [
    (inputs.import-tree ./modules)
  ];

  # Firefox Wayland fixes
  home.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  home.sessionVariables.MOZ_DBUS_REMOTE = "1";

  targets.genericLinux.enable = true;
  # enable Hyprland
  home.stateVersion = "25.11";
}
