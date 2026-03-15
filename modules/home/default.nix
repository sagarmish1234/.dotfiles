{ pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    # (inputs.import-tree ./modules) # Commented out to debug path issue
    # Stylix and NVF home-manager modules
    inputs.stylix.homeModules.stylix
    inputs.nvf.homeManagerModules.default
  ];

  # Firefox Wayland fixes
  home.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  home.sessionVariables.MOZ_DBUS_REMOTE = "1";

  home.packages = [
    unstable.codecrafters-cli
  ];
  targets.genericLinux.enable = true;
  # enable Hyprland
  home.stateVersion = "25.11";
}
