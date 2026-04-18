{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    (inputs.import-tree ./modules)
  ];
  targets.genericLinux.enable = true;
  # enable Hyprland
  home.stateVersion = "25.11";
}
