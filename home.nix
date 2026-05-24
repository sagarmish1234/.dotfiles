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

  sops = {
    age.keyFile = "/home/sagar/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/rclone.yaml;
  };
}
