{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    (inputs.import-tree ./modules)
    ./modules/eww.nix
  ];
  targets.genericLinux.enable = true;
  # enable Hyprland
  home.stateVersion = "25.11";
}
